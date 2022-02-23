package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class KnowledgeVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String sid;
	
	private long knowlgNo;
	
	private String title;
	
	private String cont;
	
	private long knowlgMapMainNo;
	
	private long knowlgMapSubNo;
	
	private long knowlgMapNo;
	
	private String knowlgMapNm;
	
	private long upNo;
	
	private String upNm;
	
	private String knowlgMapType;
	
	private String summry;
	
	private String aprvYn;
	
	private String aprvCont;
	
	private String approverId;
	
	private String rlsYn;
	
	private String realNmYn;
	
	private String copertnWritngYn;
	
	private String ouCode;
	
	private long inqCnt;
	
	private long cmmntyNo;
	
	private long downloadCnt;
	
	private long atchFileNo;
	
	private long relateKnowlgNo;
	
	private long targetNo;
	
	private int sortOrdr;
	
	private String relateKnowlgTitle;
	
	private String keyword;
	
	private long recommend;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private String delYn;
	
	private Boolean isNew;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;

	private String searchType;
	
	private String searchText;
	
	private String displayName;
	
	private String searchDate;
	
	private String searchWriter;
	
	private String startDate;
	
	private String endDate;
	
	private String ou;
	
	private String mileageType;
	
	private float mileageScore;

	private int recommendCnt;
	
	private int interestsCnt;
	
	private String isMyList;
	
	private List<String> relateKnowledgeList;
	
	private List<String> orgList;
	
	private List<String> userList;
	
	private List<String> groupList;
	
	private List<KnowledgeContentsVO> knowledgeContentsList;
	
	private List<KnowledgeVO> knowledgeList;
	
}
