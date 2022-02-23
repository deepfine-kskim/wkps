package egovframework.com.utl.wed.enums;

public enum SurveySearchKey {

    TITLE("설문주제"), REGISTER_ID("작성자");

    private String value;

    SurveySearchKey(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
