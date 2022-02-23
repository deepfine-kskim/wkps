package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrgMileageVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long orgMileageNo;
	
	private String mileageType;
	
	private long knowlgNo;
	
	private String title;
	
	private int mileageScore;
	
	private int totalScore;
	
	private String ouCode;
	
	private String ou;
	
	private Date registDtm;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchText;
	
	List<OrgMileageVO> orgMileageList;
	
}
