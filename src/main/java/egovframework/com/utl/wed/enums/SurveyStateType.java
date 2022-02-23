package egovframework.com.utl.wed.enums;

public enum SurveyStateType {

    ALL("전체"), TEMPORARY("임시저장"), DOING("진행중"), DONE("완료"), WAIT("승인대기"), CANCEL("[반려]"), MINE("참여"), WRITE("작성");

    private String value;

    SurveyStateType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
