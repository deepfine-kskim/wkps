package egovframework.com.utl.wed.enums;

public enum SurveyQuestionType {

    DESCRIPTION("서술형"), SINGLE("단일 선택형"), MULTI("복수 선택형"), SKIP("건너뛰기 형");

    private String value;

    SurveyQuestionType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
