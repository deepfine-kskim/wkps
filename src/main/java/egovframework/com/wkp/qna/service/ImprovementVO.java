package egovframework.com.wkp.qna.service;

import egovframework.com.cmm.service.FileVO;
import lombok.Data;

import java.sql.Date;
import java.util.List;

@Data
public class ImprovementVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private Long improvementNo;

	private Long improvementAnswerNo;

	private String title;

	private String cont;

	private String registerId;

	private Date registDtm;

	private String updaterId;

	private Date updDtm;

	private String delYn;

	private Long atchFileNo;

	private List<FileVO> fileList;

	private Integer page = 1;

	private Integer itemCountPerPage = 10;

	private Integer itemOffset = 0;

	private String searchType;

	private String searchText;

	private String displayName;

	private List<ImprovementVO> answerList;

}
