package egovframework.com.wkp.srv.service;


import egovframework.com.utl.wed.enums.SurveyStateType;
import lombok.Data;

import java.util.List;

@Data
public class SurveyDTO {

	private Long surveyNo;
	private String bngnDtm;
	private String endDtm;
	private String resltRlsYn;
	private String title;
	private String surveyDesc;
	private SurveyStateType aprvState;
	private String targetYn;
	private String rlsYn;
	private String targetRlsYn;
	
	private List<String> orgList;

	private List<String> userList;

	private List<String> groupList;

	private List<SurveyQuestionVO> questionList;

}
