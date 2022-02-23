package egovframework.com.cmm;

import lombok.Data;

@Data
public class ResBase{
	public boolean success;
	public int errorCode;
	public String errorMessage;
}
