package egovframework.com.wkp.qna.service;

import java.sql.Date;
import java.util.List;

import egovframework.com.cmm.service.FileVO;
import lombok.Data;

@Data
public class FaqVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long faqNo;
	
	private String faqType;
	
	private String title;
	
	private String cont;  
	
	private long inqCnt;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private String displayName;
	
	private Date updDtm;
	
	private String delYn;
	
	private long atchFileNo;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchType;
	
	private String searchText;
	
	private List<FileVO> fileList;
	
	private List<FaqVO> faqList;
	
}
