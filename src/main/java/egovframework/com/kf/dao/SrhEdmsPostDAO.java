package egovframework.com.kf.dao;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import egovframework.com.kf.common.CommonUtil;
import egovframework.com.kf.common.DCUtil;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import konan.docruzer.DOCRUZER;

import java.io.IOException;
import java.rmi.server.ExportException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SrhEdmsPostDAO {
	
	
    /**
     * 엔진 공통 유틸
     */
    @Resource(name = "dcUtil")
    private DCUtil dcUtil;

    /**
     * common util Setting
     */
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
	
	 /**
     * EgovPropertyService
     */
    @Resource(name = "konanPropertiesService")
    protected EgovPropertyService konanPropertiesService;
	
	public int SrhPost(ParameterVO paramVO, Model model) throws Exception {
	int rc=0,total=0;
	long hc;
	int pagenum = (paramVO.getPageNum() - 1) * paramVO.getPageSize();
    int pagesize= paramVO.getPageSize();
    int port= Integer.parseInt(konanPropertiesService.getString("docPort"));
	
	DOCRUZER crz = new DOCRUZER();
	hc= crz.CreateHandle();
	if(hc<0) {
		return 0;
	}
	
	//검색서버 응답대기시간 설정
	rc=crz.SetOption(hc,crz.OPTION_SOCKET_CONNECTION_TIMEOUT_MSEC, 5);
	if(rc<0) {
		return 0;
	}
	
	//userid검색
	String usersrh="loginid='"+paramVO.getUserId()+"'";
	String userid = null;
	try {
		rc = crz.SubmitQuery(hc, konanPropertiesService.getString("docIP"), port, "", "", 
    			"userMapping", usersrh, "", "", 0, pagesize, crz.LC_KOREAN, 
    			crz.CS_UTF8);
		if(rc>=0) {
			int col =crz.GetResult_ColumnSize(hc);
			String[] field_data= new String[col];
			crz.GetResult_Row(hc, field_data, 0);
			userid=field_data[0];
		}
	}catch(Exception e){
    	
    }
	
	String scn = "edmsPost";
	StringBuffer query = new StringBuffer();
	
	//기본쿼리
    query.append("text_idx = '");
    query.append(dcUtil.escapeQuery(paramVO.getKwd()));
    query.append("' allword synonym ");
    		
			
    if (paramVO.getReSearch()) {
        String[] preKwds = paramVO.getPreviousQueries();
        //이전키워드
        for (String prekwd : preKwds) {
            if (!prekwd.isEmpty() && !prekwd.equals(paramVO.getKwd())) {
                query.append(" and ");
                query.append("text_idx = '");
                query.append(prekwd);
                query.append("' allword synonym ");
            }
        }

    }
    //검색권한조건
    //query.append("and (open_flag='DPBT1' or dept_cd = '"+paramVO.getDeptNm()+"' or writer_id='"+paramVO.getUserId()+"') ");
    //query.append("and (open_flag='DPBT1' or dept_cd = '"+paramVO.getDeptNm()+"' or writer_id='"+userid+"') ");
    query.append("and (open_flag='DPBT1') ");

    /**
     * 날짜검색기간 조회
     * 기간/일/월/년도, 구간검색으로 조회시 자바스크립트에서 시작날짜와 종료날짜 조회하여 전달함.
     */
    if (!paramVO.getStartDate().isEmpty()) {
        query.append(" AND reg_dt  >= '").append(paramVO.getStartDate()).append("' ");
    }

    if (!paramVO.getEndDate().isEmpty()) {
        query.append(" AND reg_dt  <= '").append(paramVO.getEndDate()).append("' ");
    }

    //정렬조건
    query.append(" order by ");
    String sort = paramVO.getSort();
    if ("r".equals(sort)) {    //정확도
        query.append(" $relevance desc ");
    } else {   //최신순
        query.append(" reg_dt desc ");
    }
    String qry = query.toString();
    //System.out.println("result query ::::: "+qry);
    List<Map<String, String>> result = new ArrayList<>();;
    Map<String, String> map ;
    try {
    	//rc = crz.SubmitQuery(hc, konanPropertiesService.getString("docIP"), port, "", "", 
    	//		scn, qry, "", "", pagenum, pagesize, crz.LC_KOREAN, 
    	//		crz.CS_UTF8);
    	
    	//Konan YJH 2021.12.22 수정. 행정포탈 엔진인 KS5업그레이드 이후 전자결제 검색이 안되는 현상
    	rc = crz.Search(hc, konanPropertiesService.getString("docIP")+":7577", scn, qry,"","","",pagenum,pagesize,crz.LC_KOREAN,crz.CS_UTF8);
    	
    	if(rc>=0) {
    		total=crz.GetResult_TotalCount(hc);	//검색데이터 총 갯수
    		model.addAttribute("edmsPostTotal", crz.GetResult_TotalCount(hc));
    		int row = crz.GetResult_RowSize(hc);
    		int col =crz.GetResult_ColumnSize(hc);
    		String[] field_data= new String[col];
    		//int dpbt1_cnt = 0;
    		for(int i=0; i<row;i++) {
    			map = new HashMap<>();
    			crz.GetResult_Row(hc, field_data, i);
    			map.put("doc_id", field_data[0]);
					/*
					 * if(field_data[3]=="DPBT1") { map.put("open_flag", "공개"); }else
					 * if(field_data[3]=="DPBT2") { map.put("open_flag", "비공개"); }else {
					 * map.put("open_flag", "부분공개"); }
					 */
    			if(field_data[3].equals("DPBT1")) {
    				//dpbt1_cnt += 1;
    				map.put("open_flag", "공개");
    				map.put("title", field_data[4]);
            		map.put("dept_nm", field_data[5]);
            		map.put("writer_nm", field_data[7]);
            		map.put("reg_dttm", field_data[9]);
            		if("".equals(field_data[18].trim())) { map.put("filename", field_data[18]);
            		} else {
            			String[] fileNms = field_data[18].split("\\|");
            			String filelist = null;
            			for(int j=0;j<fileNms.length;j++) {
            				if(j==0) { filelist=fileNms[j];}
            				else{ filelist+=","+fileNms[j]; }
            			}
            			map.put("filename", filelist);
            		}
            		result.add(map);
					} /*
						 * else if(field_data[3].equals("DPBT2")) { map.put("open_flag", "비공개"); } else
						 * if(field_data[3].equals("DPBT3")) { map.put("open_flag", "부분공개"); }
						 */
    			else {
    				map.clear();
    			}
    			//map.put("open_flag", field_data[3]);
					/*
					 * map.put("title", field_data[4]); map.put("dept_nm", field_data[5]);
					 * map.put("writer_nm", field_data[7]); map.put("reg_dttm", field_data[9]);
					 * if("".equals(field_data[18].trim())) { map.put("filename", field_data[18]); }
					 * else { String[] fileNms = field_data[18].split("\\|"); String filelist =
					 * null; for(int j=0;j<fileNms.length;j++) { if(j==0) { filelist=fileNms[j];}
					 * else{ filelist+=","+fileNms[j]; } } map.put("filename", filelist); }
					 */
    			//result.add(map);
    		}
    		//model.addAttribute("edmsPostTotal", dpbt1_cnt);
    		model.addAttribute("edmsPostList", result);
    		
    	}
    }catch(Exception e){
    	
    }
    
    crz.DestroyHandle(hc);
	
	return total;
	}
}
