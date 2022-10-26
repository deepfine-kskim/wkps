package egovframework.com.wkp.srv.service;


import egovframework.com.utl.wed.enums.SurveySearchKey;
import egovframework.com.utl.wed.enums.SurveyStateType;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class SurveyVO {

	private Long surveyNo;
	private Long surveyAnswerNo;
	private Long surveyQusNo;
	private Long surveyExampleNo;
	private Date bngnDtm;
	private Date endDtm;
	private String resltRlsYn;
	private String title;
	private String surveyDesc;
	private String qusAnswerCont;
	private SurveyStateType aprvState;
	private String registerId;
	private String ouCode;
	private Date registDtm;
	private String updaterId;
	private String updDtm;
	private String registerName;
	private String checkRegisterName;
	private String checkRegisterOu;
	private String updaterName;
	private String delYn;
	private String targetYn;
	private Date checkDtm;
	private String checkRegisterId;
	private String checkCont;
	private long targetNo;
	private String rlsYn;
	private String targetRlsYn;
	private String isFront;
	private String sid;
	private String roleCd;

	private boolean mine;

	private List<SurveyQuestionVO> questionList;

	private Integer page;
	private Integer itemCountPerPage = 10;
	private Integer itemOffset = 0;
	private String searchText;
	private SurveySearchKey searchKey;

}
