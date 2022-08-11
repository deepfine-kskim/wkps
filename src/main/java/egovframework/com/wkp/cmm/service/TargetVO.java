package egovframework.com.wkp.cmm.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class TargetVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long targetNo;
	
	private int sortOrdr;
	
	private String targetTypeCd;
	
	private String targetCode;
	
	private Date registDtm;
	
	private List<String> orgList;
	
	private List<String> userList;
	
	private List<String> groupList;
	
	//수정화면에서 필요
	private String dispName;

	private String ou;

	private String name;
}
