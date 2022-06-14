package egovframework.com.wkp.req.service;

import lombok.Data;

import java.sql.Date;
import java.util.List;

@Data
public class ReqVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long requstNo;
	
	private String knowlgMapType;
	
	private long knowlgMapNo;

	private String upNm;
	
	private String knowlgMapNm;
	
	private String title;
	
	private String cont;  
	
	private long inqCnt;
	
	private String answerYn;
	
	private String answerId;
	
	private Date answerDtm;
	
	private String answerDisplayName;
	
	private String answerOu;
	
	private String answerCont;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private String displayName;
	
	private String ou;
	
	private String delYn;
	
	private long atchFileNo;
	
	private Boolean isNew;
	
	private Integer page = 1;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchType;
	
	private String searchText;
	
	private List<ReqVO> requestList;

	private Long requstAnswerNo;

	private String slctnYn;

	private String selectionYn;

}
