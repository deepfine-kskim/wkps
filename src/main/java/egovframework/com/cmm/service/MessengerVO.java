package egovframework.com.cmm.service;

import lombok.Data;

@Data
public class MessengerVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String sysName;

	private String sndUser;

	private String recvId;

	private String docTitle;

	private String docDesc;

	private String docUrl;

	private String inputDate;

}
