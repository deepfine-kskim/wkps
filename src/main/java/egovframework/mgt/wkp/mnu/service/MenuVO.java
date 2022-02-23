package egovframework.mgt.wkp.mnu.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MenuVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private long menuNo;
	
	private String menuNm;
	
	private String menuUrl;
	
	private long upNo;
	
	private int sortOrdr;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private char delYn;
	
	private String menuDesc;
	
	private List<MenuVO> menuList;
	
}
