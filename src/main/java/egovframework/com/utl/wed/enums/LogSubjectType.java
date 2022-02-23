package egovframework.com.utl.wed.enums;

public enum LogSubjectType {

    ALL("전체"),COMMUNITY("커뮤니티"), SURVEY("설문조사"), QNA("Q&A"),CALENDAR("달력")
    ,KNOWLEDGE("지식"),KNOWLGMAP("지식맵"),FAQ("FAQ"),NOTICE("공지사항"),LOGIN("로그인"),MYPAGE("마이페이지"), MAIN("메인"), REQUEST("요청"), INTERESTS("관심분야");

    private String value;

    LogSubjectType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
