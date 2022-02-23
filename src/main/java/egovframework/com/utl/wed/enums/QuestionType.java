package egovframework.com.utl.wed.enums;

public enum QuestionType {

    ALL("전체"), DOING("진행중인 QA"), DONE("완료된 QA"), MINE("나의 질문"),MINEANSWER("나의 답변") ;

    private String value;

    QuestionType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
