package egovframework.com.utl.wed.enums;

public enum SurveyType {

    ALL("전체"), DOING("진행중인 설문"), DONE("완료된 설문"), MINE("내가 참여한 설문"), WRITE("내가 작성한 설문");

    private String value;

    SurveyType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
