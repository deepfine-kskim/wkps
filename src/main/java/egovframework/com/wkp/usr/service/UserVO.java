package egovframework.com.wkp.usr.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String sid;
	
	private String ou;
	
	private String ouCode;
	
	private int ouLevel;
	
	private String parentOuCode;
	
	private String topOuCode;
	
	private String uid;
	
	private String displayName;
	
	private String userFullName;
	
	private String positionCode;
	
	private String position;
	
	private String titleCode;
	
	private String title;
	
	private String titleOrPosition;
	
	private String mail;
	
	private String telephoneNumber;
	
	private String facsimileTelephoneNumber;
	
	private String orgFullName;
	
	private int ordr;
	
	private String mobile;
	
	private String jobtitledate;
	
	private String jobTitle;
	
	private String nickName;
	
	private String roleCd;
	
	private String roleNm;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private float mileageScore;
	
	private long atchFileNo;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchText;
	
	private String approverYn;
	
	private List<UserVO> userList;

}