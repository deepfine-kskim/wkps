package egovframework.com.wkp.srv.service;


import egovframework.com.utl.wed.enums.SurveyQuestionType;
import lombok.Data;

@Data
public class SurveyStatisticsDTO {

	private Long surveyQusNo;
	private Long surveyExampleNo;
	private Long surveyNo;
	private SurveyQuestionType qusTypeCd;
	private String cont;
	private String exCont;
	private Integer orderNo;
	private Integer exOrderNo;
	private int exCount;
	private boolean mine;
	private String registerId;

}
