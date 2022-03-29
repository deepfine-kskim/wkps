package egovframework.com.wkp.cmm.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class PersonalizeVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String knowlgMapType;
	
	private String ouCode;
	
	private String ou;
	
	private String title;
	
	private String summry;
	
	private int rki;
	
	private long inqCnt;
	
	private int recomendCnt;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private List<PersonalizeVO> personalizeList;

	private long knowlgNo;
}
