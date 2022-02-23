package egovframework.com.utl.wed.enums;

public enum LogType {

    INSERT_COMMENT("댓글입력")
    ,INSERT_ANSWER("답변입력")
    ,UPDATE_ANSWER_CHOICE("답변채택")
    ,INSERT_ANSWER_RECOMMENDATION("답변추천")
    ,DELETE_ANSWER_RECOMMENDATION("답변추천 취소")
    ,INSERT_KNOWLG_RECOMMENDATION("지식추천")
    ,DELETE_KNOWLG_RECOMMENDATION("지식추천 취소")
    ,INSERT_KNOWLG_INTEREST("관심분야")
    ,DELETE_KNOWLG_INTEREST("관심분야 취소")
    ,INSERT("입력"), UPDATE("수정"), DELETE("삭제")
    ,SELECT_DETAIL("상세읽기"),SELECT_LIST("리스트읽기"),SELECT_RESULT("결과페이지")
    ,DOWNLOAD_EXCEL("엑셀다운로드")
    ,LOGIN("로그인"),LOGOUT("로그아웃");

    private String value;

    LogType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
