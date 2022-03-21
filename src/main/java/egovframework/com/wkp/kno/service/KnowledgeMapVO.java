package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class KnowledgeMapVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private long knowlgMapNo;
	
	private String knowlgMapNm;
	
	private String knowlgMapType;
	
	private long upNo;
	
	private String upNm;
	
	private int sortOrdr;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private char delYn;
	
	private List<KnowledgeMapVO> knowledgeMapList;

	private String link;

	private String showYn;
	
}
