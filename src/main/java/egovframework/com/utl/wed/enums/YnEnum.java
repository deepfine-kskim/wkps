package egovframework.com.utl.wed.enums;

public enum YnEnum {

    Y("Y"), N("N");

    private String value;

    YnEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
