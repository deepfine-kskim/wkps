package egovframework.com.kf.dao;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.hsqldb.lib.HashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.kf.common.CommonUtil;
import egovframework.com.kf.common.DCUtil;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.data.SearchVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * Class Name : SrhKnowledgeDAO.java
 * Description : 검색대상 knowledge 조회
 *
 * Modification Information
 *
 * 수정일                        수정자           수정내용
 * --------------------  -----------  ---------------------------------------
 * 2017년 12월  00일                       최초 작성
 *
 * @since 2017년
 * @version V1.0
 * @see (c) Copyright (C) by KONANTECH All right reserved
 */
@Repository
public class SrhFaqDAO {
	private static final Logger SRH_FAQ_LOGGER = LoggerFactory.getLogger(SrhFaqDAO.class);
	
	/** 엔진 공통 유틸 */
	@Resource(name = "dcUtil")
	private DCUtil dcUtil;
	
	/** common util Setting */
	@Resource(name = "commonUtil")
	private CommonUtil commonUtil;
	
	/** REST 모듈 */
	@Resource(name = "restModule")
	private RestModule restModule;
		
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;	

	/**
	 * 키워드에 맞는 문서관리 내용 리턴
	 * 
	 * @param kwd
	 * @throws IOException 
	 */
	public RestResultVO FaqSearch(ParameterVO paramVO) throws Exception {
		SearchVO searchVO = new SearchVO();		
		// 쿼리 생성
		StringBuffer query = new StringBuffer();
		StringBuffer sbLog = new StringBuffer();
		String strNmFd;
		
		// boolean 검색여부 확인
		String likeField = paramVO.getLikefield();
		//기본쿼리
		if(paramVO.getSchAreaAll().equals("true") || ("false".equals(paramVO.getSchArea1())&&"false".equals(paramVO.getSchArea2())&&"false".equals(paramVO.getSchArea3()))) {
			query.append("text_idx = '");
			query.append(dcUtil.escapeQuery(paramVO.getKwd()) );
			query.append("' allword synonym ");
		}
		else if(paramVO.getSchAreaAll().equals("false")) {
			query.append("(");
			if("true".equals(paramVO.getSchArea1())) {
				query.append("title = '");
				query.append(dcUtil.escapeQuery(paramVO.getKwd()) );
				query.append("' allword synonym ");
			}
			if("true".equals(paramVO.getSchArea2())) {
				if("true".equals(paramVO.getSchArea1())) {
					query.append(" or ");
				}
				query.append("cont = '");
				query.append(dcUtil.escapeQuery(paramVO.getKwd()) );
				query.append("' allword synonym ");
			}
			if("true".equals(paramVO.getSchArea3())) {
				if("true".equals(paramVO.getSchArea1()) || "true".equals(paramVO.getSchArea2())) {
					query.append(" or ");
				}
				query.append("orignl_file_nm = '");
				query.append(dcUtil.escapeQuery(paramVO.getKwd()) );
				query.append("' allword synonym ");
				query.append("or file_cn = '");
				query.append(dcUtil.escapeQuery(paramVO.getKwd()) );
				query.append("' allword synonym ");
			}
			query.append(")");
		}


//		logger.debug(">>>> query1: "+query.toString());
		
		//결과내재검색
		if( paramVO.getReSearch() ){
			String[] preKwds = paramVO.getPreviousQueries();
			/*
			if(preKwds.length > 0) {
				query.insert(0, "( ");
				query.append(" )  ");
			}
			*/
			//이전키워드
			for (String prekwd : preKwds) {
				if(!prekwd.isEmpty()  && !prekwd.equals(paramVO.getKwd())) {
					
					if(paramVO.getSchAreaAll().equals("true") || ("false".equals(paramVO.getSchArea1())&&"false".equals(paramVO.getSchArea2())&&"false".equals(paramVO.getSchArea3()))) {
						query.append(" and ");
						query.append("text_idx = '");
						query.append(prekwd);
						query.append("' allword synonym ");
					}
					else if(paramVO.getSchAreaAll().equals("false")) {
						query.append(" and (");
						if("true".equals(paramVO.getSchArea1())) {
							query.append("title = '");
							query.append(prekwd);
							query.append("' allword synonym ");
						}
						if("true".equals(paramVO.getSchArea2())) {
							if("true".equals(paramVO.getSchArea1())) {
								query.append(" or ");
							}
							query.append("cont = '");
							query.append(prekwd);
							query.append("' allword synonym ");
						}
						if("true".equals(paramVO.getSchArea3())) {
							if("true".equals(paramVO.getSchArea1()) || "true".equals(paramVO.getSchArea2())) {
								query.append(" or ");
							}
							query.append("orignl_file_nm = '");
							query.append(prekwd);
							query.append("' allword synonym ");
							query.append("or file_cn = '");
							query.append(prekwd);
							query.append("' allword synonym ");
						}
						query.append(")");
					}
				}
			}

		}	

		/**
		 * 날짜검색기간 조회
		 * 기간/일/월/년도, 구간검색으로 조회시 자바스크립트에서 시작날짜와 종료날짜 조회하여 전달함.
		 */
		if (!paramVO.getStartDate().isEmpty() ) {
			query.append(" AND regist_dtm  >= '").append(paramVO.getStartDate()).append("' ");
		}
		
		if (!paramVO.getEndDate().isEmpty() ) {
			query.append(" AND regist_dtm  <= '").append(paramVO.getEndDate()).append("' ");
		}
		
		//사용자검색(관리자제외)
/*		if(!"admin".equals(paramVO.getUserId()) ) {
			query.append(" AND ( authority  ='").append(paramVO.getUserId()).append("'  allword OR authority  ='all'   allword ) ");
		}*/

		//정렬조건	
		query.append(" order by ");
		String sort = paramVO.getSort();
		if("r".equals(sort)) {    //정확도
			query.append(" $relevance desc ");
		}
		else{   //최신순
			query.append(" regist_dtm desc ");
		}
		

//		logger.debug("db query>> "+query.toString());
		
		//로그기록 
		//SITE@인물+$|첫검색|1|정확도순^코난	     
		sbLog.append(  dcUtil.getLogInfo(commonUtil.null2Str(paramVO.getSiteNm(),"경기도청"),
				"FAQ" ,
				commonUtil.null2Str( paramVO.getUserId(),""), paramVO.getKwd(),
				paramVO.getPageNum(),
				paramVO.getReSearch(),
				paramVO.getSiteNm(),
				commonUtil.null2Str( paramVO.getRecKwd(),"" )) );
	
		searchVO.setUrl(konanPropertiesService.getString("url"));
		searchVO.setCharset(konanPropertiesService.getString("charset"));
		searchVO.setFields(konanPropertiesService.getString("faqField"));
		searchVO.setFrom(konanPropertiesService.getString("faqFrom"));
		searchVO.setHilightTxt(konanPropertiesService.getString("defaultHilight"));

		
		searchVO.setQuery(URLEncoder.encode(query.toString(), konanPropertiesService.getString("charset") ));
		searchVO.setLogInfo(URLEncoder.encode(sbLog.toString(), konanPropertiesService.getString("charset")));
	
		// URL 생성
		String restUrl = dcUtil.getRestURL(paramVO, searchVO); //get방식 URL생성
		//String postParamData = dcUtil.getParamPostData(paramVO, searchVO);
		SRH_FAQ_LOGGER.debug("faq restUrl>>"+restUrl);
		
		
		RestResultVO restVO = new RestResultVO();
		//boolean success = restModule.restSearch(restUrl, restVO, searchVO.getFields());  //get방식 호출
		boolean success = restModule.restSearch(restUrl, restVO, searchVO.getFields()); //post 방식 호출
		
		//초기화
		query.charAt(0);
		sbLog.charAt(0);
		
		if(!success) {
			SRH_FAQ_LOGGER.error("dbDao error>>>");
			return null;
		}
		return restVO;		
	}
	
}
