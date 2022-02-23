package egovframework.com.kf.data;

/**
 * Class Name : ParameterVO.java
 * Description : 검색엔진 파라미터 VO
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
public class ParameterVO {

    /** 검색키워드 */
    private String kwd;
    private String kwd1;
    
    /** 이전검색어 배열 */
    public String preKwds;
    
    /** 검색 카테고리(탭) */
    private String category;
    private String[] categorySch;
    private String schCate1;
    private String schCate2;
    private String schCate3;
    private String schCate4;
    private String schCate5;
    
    /** 검색 서브카테고리 */
    private String subCategory;
		
	/** 검색대상 필드 */
	private String srchFd;

	/** 유저 ID */
	private String userId;
	/** 사용자부서코드 */
	private String deptNm;
	
	/** 사이트명 */
	private String siteNm;

    /** 추천검색어 정보 */
    private String recKwd;

    /** 재검색 여부 (boolean) */
    private boolean reSearch;

    /** 페이지사이즈 */
    private int pageSize;
    
    /** 검색결과페이지번호 */
    private int pageNum;
    
    /** 검색결과페이지번호 */
    private int offSet;
    
    /** 정렬 */
    private String sort;
    
    /** 정렬명 */
    private String sortNm;

	/** 상세검색 여부 플래그 */
    private boolean detailSearch;
    
	/** 제외어 */
    private String exclusiveKwd;
  
	/** 날짜선택사항 */
    private String date;

	/** 시작일 */
	private String startDate;
	
	/** 종료일 */
	private String endDate;
	
	/** 첨부파일 확장자 */
    private String fileExt;
	
    /** 작성자 */
    private String writer;
    
    /** 검색결과 최종 값 */
    private int total;
    
    /** 연도- 배열*/
    private String year;
    
    /** 호출한 위치 */
    private String callLoc;
    
    /** 이미지 뷰어 rowid */
    private int imageRowNo;
    
    /** 시나리오 */
    private String scenario;
    
    /** 하이라이트 키워드 */
    private String hilightKwd;
    private String hilightKwd1;
 
    /** 오늘날짜 20160706 */
    private String nowDate;
    
    /** 검색영역 20160706*/
    private String fields;   
    
    /** andOrNot 선택 **/
    private String andor;
    
    
    private String selectSortType;
    private String likefield;
    private String titlecase;
    private String titlematch;
    
    private String schAreaAll;
    private String schArea1;
    private String schArea2;
    private String schArea3;
    
    /** 쿼리 추가*/
    private String originalQuery;
	private String previousQuery;
	private String[] previousQueries; 
   
	public String getKwd() {
		return kwd;
	}

	public void setKwd(String kwd) {
		this.kwd = kwd;
	}
	
	public String getKwd1() {
		return kwd1;
	}

	public void setKwd1(String kwd1) {
		this.kwd1 = kwd1;
	}
	
	public String getPreKwds() {
		return preKwds;
	}

	public void setPreKwds(String preKwds) {
		this.preKwds = preKwds;
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	public String[] getCategorySch() {
		return categorySch;
	}

	public void setCategorySch(String[] categorySch) {
		this.categorySch = categorySch;
	}


	public String getRecKwd() {
		return recKwd;
	}

	public void setRecKwd(String recKwd) {
		this.recKwd = recKwd;
	}

	public boolean getReSearch() {
		return reSearch;
	}

	public void setReSearch(boolean reSearch) {
		this.reSearch = reSearch;
	}

	public String getSrchFd() {
		return srchFd;
	}

	public void setSrchFd(String srchFd) {
		this.srchFd = srchFd;
	}
	
	public String getSiteNm() {
		return siteNm;
	}

	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}
	
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getOffSet() {
		return offSet;
	}

	public void setOffSet(int offSet) {
		this.offSet = offSet;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
		
    public String getSortNm() {
		return sortNm;
	}

	public void setSortNm(String sortNm) {
		this.sortNm = sortNm;
	}

	public boolean getDetailSearch() {
		return detailSearch;
	}

	public void setDetailSearch(boolean detailSearch) {
		this.detailSearch = detailSearch;
	}
	
	public String getExclusiveKwd() {
		return exclusiveKwd;
	}

	public void setExclusiveKwd(String exclusiveKwd) {
		this.exclusiveKwd = exclusiveKwd;
	}	
	  
    public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	/**
	 * @return the total
	 */
	public int getTotal() {
		return total;
	}

	/**
	 * @param total the total to set
	 */
	public void setTotal(int total) {
		this.total = total;
	}

	/**
	 * @param count
	 */
	public void addTotal(int count) {
		this.total += count;
	}

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	
	public String getYear() {
		return year;
	}
	
	public void setYear(String year) {
		this.year = year;
	}
	
	 public String getCallLoc() {
			return callLoc;
	}

	public void setCallLoc(String callLoc) {
		this.callLoc = callLoc;
	}

	public int getImageRowNo() {
		return imageRowNo;
	}

	public void setImageRowNo(int imageRowNo) {
		this.imageRowNo = imageRowNo;
	}

	public String getScenario() {
		return scenario;
	}

	public void setScenario(String scenario) {
		this.scenario = scenario;
	}

	public String getHilightKwd() {
		return hilightKwd;
	}

	public void setHilightKwd(String hilightKwd) {
		this.hilightKwd = hilightKwd;
	}
	
	public String getHilightKwd1() {
		return hilightKwd1;
	}

	public void setHilightKwd1(String hilightKwd1) {
		this.hilightKwd1 = hilightKwd1;
	}
	
	public String getNowDate() {
		return nowDate;
	}

	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}
	
	public String getFields() {
		return fields;
	}

	public void setFields(String fields) {
		this.fields = fields;
	}
	
	public String getPreviousQuery() {
		return previousQuery;
	}

	public void setPreviousQuery(String previousQuery) {
		this.previousQuery = previousQuery;
	}
	
	public String getOriginalQuery() {
		return originalQuery;
	}

	public void setOriginalQuery(String originalQuery) {
		this.originalQuery = originalQuery;
	}
	
	public String[] getPreviousQueries() {
		return previousQueries;
	}

	public void setPreviousQueries(String[] previousQueries) {
		this.previousQueries = previousQueries;
	}

	public String getAndor() {
		return andor;
	}

	public void setAndor(String andor) {
		this.andor = andor;
	}

	public String getSelectSortType() {
		return selectSortType;
	}

	public void setSelectSortType(String selectSortType) {
		this.selectSortType = selectSortType;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userid) {
		this.userId = userid;
	}

	public String getLikefield() {
		return likefield;
	}

	public void setLikefield(String likefield) {
		this.likefield = likefield;
	}

	public String getTitlecase() {
		return titlecase;
	}

	public void setTitlecase(String titlecase) {
		this.titlecase = titlecase;
	}

	public String getSchAreaAll() {
		return schAreaAll;
	}

	public void setSchAreaAll(String schAreaAll) {
		this.schAreaAll = schAreaAll;
	}
	public String getSchArea1() {
		return schArea1;
	}

	public void setSchArea1(String schArea1) {
		this.schArea1 = schArea1;
	}
	public String getSchArea2() {
		return schArea2;
	}

	public void setSchArea2(String schArea2) {
		this.schArea2 = schArea2;
	}
	public String getSchArea3() {
		return schArea3;
	}

	public void setSchArea3(String schArea3) {
		this.schArea3 = schArea3;
	}
	public String getTitlematch() {
		return titlematch;
	}

	public void setTitlematch(String titlematch) {
		this.titlematch = titlematch;
	}

	public String getSchCate1() {
		return schCate1;
	}

	public void setSchCate1(String schCate1) {
		this.schCate1 = schCate1;
	}

	public String getSchCate2() {
		return schCate2;
	}

	public void setSchCate2(String schCate2) {
		this.schCate2 = schCate2;
	}

	public String getSchCate3() {
		return schCate3;
	}

	public void setSchCate3(String schCate3) {
		this.schCate3 = schCate3;
	}

	public String getSchCate4() {
		return schCate4;
	}

	public void setSchCate4(String schCate4) {
		this.schCate4 = schCate4;
	}

	public String getSchCate5() {
		return schCate5;
	}

	public void setSchCate5(String schCate5) {
		this.schCate5 = schCate5;
	}

	public boolean isReSearch() {
		return reSearch;
	}

	public boolean isDetailSearch() {
		return detailSearch;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
}