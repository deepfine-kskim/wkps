package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class KnowledgeContentsVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long knowlgNo;
	
	private String title;
	
	private int sortOrdr;
	
	private String subtitle;
	
	private String cont;
	
	private long upNo;
		
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private String delYn;
	
	private List<KnowledgeContentsVO> knowledgeContentsList;

	private String requestContent;

	private Long requestNo;
}
