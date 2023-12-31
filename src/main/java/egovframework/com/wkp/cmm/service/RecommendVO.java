package egovframework.com.wkp.cmm.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class RecommendVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String knowlgMapType;
		
	private String title;
	
	private String summry;
	
	private int rki;
	
	private long inqCnt;
	
	private int recomendCnt;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private List<RecommendVO> recommendList;

	private long knowlgNo;
}
