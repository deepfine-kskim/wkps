package egovframework.com.kf.common;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import java.net.*;


/**
 * Class Name : SetParameter.java
 * Description : 통합검색 조회를 파라미터 설정
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
@Component("setParameter")
public class SetParameter {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SetParameter.class);
	
	/** Common Util */
	@Resource(name = "commonUtil")
	private CommonUtil commonUtil;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;

		
	public ParameterVO setParameter(@RequestParam Map<String, String> map) {
		
		ParameterVO rtnParam = new ParameterVO();
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        
        rtnParam.setUserId(user.getSid());	// 로그인 유저 sid
        rtnParam.setDeptNm(user.getOuCode()); // 로그인 유저 부서코드

		// 사이트명
		rtnParam.setSiteNm(konanPropertiesService.getString("site"));
		
		// 키워드 (기본적으로 콤마는 삭제한다.)
		rtnParam.setKwd(getValue(map, "kwd", "", true).replaceAll("\\'", ""));
		
		// 카테고리
		rtnParam.setCategory(getValue(map, "schCate", "TOTAL", false));
		rtnParam.setCategorySch(rtnParam.getCategory().split(","));
		
		//상세검색 검색영역 선택
		rtnParam.setSchAreaAll(getValue(map, "schArea", "true", false));
		rtnParam.setSchArea1(getValue(map, "schArea1", "false", false));
		rtnParam.setSchArea2(getValue(map, "schArea2", "false", false));
		rtnParam.setSchArea3(getValue(map, "schArea3", "false", false));
		
		// 페이지 번호
		rtnParam.setPageNum(getValue(map, "pageNum", 1));
	
		// 페이지 사이즈 세팅
		if("TOTAL".equals(rtnParam.getCategory())||rtnParam.getCategorySch().length>1) {
			rtnParam.setPageSize(getValue(map, "pageSize", konanPropertiesService.getInt("pageSizeTotal")));
		} else {
			rtnParam.setPageSize(getValue(map, "pageSize", konanPropertiesService.getInt("pageSize")));
		}		
		
		// offSet 번호
		rtnParam.setOffSet((rtnParam.getPageNum()-1)*rtnParam.getPageSize() );
		// 검색대상
		rtnParam.setSrchFd(getValue(map, "srchFd", "ALL", false));
		
		// 정렬코드
		rtnParam.setSort(getValue(map, "sort", "d", false));
		
		// 정렬명
		if("r".equals(rtnParam.getSort())) {
			rtnParam.setSortNm("정확도순");
		} else {
			rtnParam.setSortNm("최신순");
		}
		
/*		// 상세검색 여부
		rtnParam.setDetailSearch(getValue(map, "detailSearch"));*/
		
/*		// 파일 확장자
		rtnParam.setFileExt(getValue(map, "fileExt", "", false));*/
		// 시작일
		if(!StringUtils.isEmpty(map.get("startDate"))) {
			String stdate=map.get("startDate").toString().replaceAll("-", "");
			if(stdate.length()==8) {
				stdate+="000000";
			}
			rtnParam.setStartDate(stdate);
		}else {
			rtnParam.setStartDate(getValue(map, "startDate", "", false));
		}
		// 종료일
		if(!StringUtils.isEmpty(map.get("endDate"))) {
			String eddate=map.get("endDate").toString().replaceAll("-", "");
			if(eddate.length()==8) {
				eddate+="000000";
			}
			rtnParam.setEndDate(eddate);
		}else {
			rtnParam.setEndDate(getValue(map, "endDate", "", false));
		}
		
		// 년도
		rtnParam.setYear(getValue(map, "year", "", false));
		
		// 작성자
		rtnParam.setWriter(getValue(map, "writer", "", false));
		
		// 제외어
		rtnParam.setExclusiveKwd(getValue(map, "notWord", "", false));
		
		// 오늘날짜
		rtnParam.setNowDate(getValue(map, "nowDate", commonUtil.getTargetDate(0), false));
		
		// 검색영역
		rtnParam.setFields(getValue(map, "fields", "", false));
		
		
		
/*		rtnParam.setSelectSortType(getValue(map, "selectSortType", "", false));
		rtnParam.setUserId(getValue(map, "userid", "admin", false));
		rtnParam.setLikefield(getValue(map, "likefield", "", false));
		rtnParam.setTitlecase(getValue(map, "titlecase", "", false));
		rtnParam.setTitlematch(getValue(map, "titlematch", "", false));*/
	
		// 재검색여부
		rtnParam.setReSearch( "true".equals(getValue(map, "reSearch", "", false))?true:false );		
		
		if("cn".equals(map.get("category")) || "jp".equals(map.get("category")))
			rtnParam.setPreKwds(map.get("preKwds"));
		else
			rtnParam.setPreKwds(getValue(map, "preKwds", "", false));
		
		
		if(rtnParam.getReSearch()){
			String[] arrPreKwd = rtnParam.getPreKwds().split("\\|");
			rtnParam.setPreviousQueries( arrPreKwd );
			if(arrPreKwd.length>1) {
				rtnParam.setRecKwd(arrPreKwd[1]);
			}
		}
		
		
		// 이전 쿼리
//		rtnParam.setPreviousQuery(getValue(map, "previousQuery", "", false));
		
		// 이전 쿼리
		rtnParam.setOriginalQuery(getValue(map, "originalQuery", "", false));		
		
		return rtnParam;
	}
	
	
	/**
	 * 파라미터 값을 바인딩한다.
	 * @param map 파라미터
	 * @param key 파라미터 키
	 * @param rtnValue null 인 경우 바인딩 
	 * @param chk <script 체크여부
	 * @return
	 */
	public String getValue(Map<String, String> map, String key, String rtnValue, boolean chk) {		
		if(StringUtils.isEmpty(map.get(key)))
			return rtnValue;

		if(!checkValue(map.get(key).toString(), chk)){
			try {
				throw new EgovComException("허용되지 않는 URL입니다.");
			} catch (EgovComException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			}
		}
		
		
		return map.get(key).toString();
	}
	
	
	/**
	 * 정수 리턴 메소드
	 * 
	 * @param map
	 * @param key
	 * @param rtnValue
	 * 
	 * @return integer
	 */
	public int getValue(Map<String, String> map, String key, int rtnValue) {
		if(StringUtils.isEmpty(map.get(key)) || !NumberUtils.isNumber(map.get(key))){
			return rtnValue;
		}
		
		return Integer.parseInt(map.get(key));
	}
	
	
	/**
	 * boolean 리턴 메소드
	 * 
	 * @param map
	 * @param key
	 * @param rtnValue
	 * 
	 * @return boolean
	 */
	public boolean getValue(Map<String, String> map, String key) {		
		if(StringUtils.isEmpty(map.get(key)))
			return false;
		
		if("true".equals(map.get(key)) || "on".equals(map.get(key)))
			return true;
		
		return false;
	}
	
	/**
	 * 문자열에 특수문자 및 이상여부를 체크하여 반환한다.
	 * @param value 문자열
	 * @param chk script, frame 체크
	 * @return
	 */
	public boolean checkValue(String value, boolean chk){		

		if(chk){
			if(  (value.toLowerCase()).indexOf("<script") > -1
					|| (value.toLowerCase()).indexOf("<frame") > -1
				    || (value.toLowerCase()).indexOf("<iframe") > -1 ) {
				return false;
			}

		}
		return true;
	}
}