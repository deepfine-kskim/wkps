package egovframework.com.wkp.usr.service;

import lombok.Data;

import java.util.List;

@Data
public class OrgVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String ou;
	
	private String topOuCode;
	
	private String parentOuCode;
	
	private String ouCode;
	
	private String cn;
	
	private String orgFullName;
	
	private int ouLevel;
	
	private int ouOrdr;
	
	private String telephoneNumber;
	
	private String ouFax;
	
	private String ouMail;
	
	private String isSidoOnly;
	
	private String status;
	
	private String isVirtual;
	
	private String virParentOUCode;

	private List<OrgVO> nextDepthList;

}
