package egovframework.com.wkp.bbs.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long noticeNo;
	
	private String title;
	
	private String cont;  
	
	private long inqCnt;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private String displayName;
	
	private String delYn;
	
	private long atchFileNo;
	
	private Boolean isNew;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchType;
	
	private String searchText;
	
	private List<NoticeVO> noticeList;
}
