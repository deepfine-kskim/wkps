package egovframework.com.wkp.srv.service;


import egovframework.com.utl.wed.enums.SurveyQuestionType;
import lombok.Data;

import java.sql.Date;

@Data
public class SurveyExcelDTO {
	private  Long surveyNo;
	private SurveyQuestionType qusTypeCd;
	private String title;
	private String qusAnswerCont;
	private String cont;
	private String exCont;
	private Integer orderNo;
	private Integer exOrderNo;
	private String registerId;
	private String registerName;
	private Date registDtm;

}
