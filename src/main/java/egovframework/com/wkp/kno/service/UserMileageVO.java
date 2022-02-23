package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserMileageVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long userMileageNo;
	
	private String mileageType;
	
	private long knowlgNo;
	
	private String title;
	
	private int mileageScore;
	
	private int totalScore;
	
	private String sid;
	
	private String displayName;
	
	private String ou;
	
	private Date registDtm;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchText;
	
	List<UserMileageVO> userMileageList;
	
}
