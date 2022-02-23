package egovframework.com.utl.wed.enums;

public enum FileType {

    AUDIO("오디오"), VIDEO("비디오"), IMAGE("이미지"), NONE("알수없음");

    private String value;

    FileType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
