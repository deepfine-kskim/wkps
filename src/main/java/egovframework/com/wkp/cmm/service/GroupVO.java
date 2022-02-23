package egovframework.com.wkp.cmm.service;

import java.util.List;

import lombok.Data;

@Data
public class GroupVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
		
	private long groupNo;
	
	private String groupNm;
	
	private int sortOrdr;
	
	private String targetTypeCd;
	
	private String targetCode;
	
	private String ouCode;
	
	private String targetName;
	
	private String registerId;
	
	private String registDtm;
	
	private String updaterId;
	
	private String updDtm;
	
	private List<String> orgList;
	
	private List<String> userList;
	
	private List<GroupVO> groupList;
}
