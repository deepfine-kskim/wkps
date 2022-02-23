/**
 * 개요
 * - 로그인정책에 대한 VO 클래스를 정의한다.
 * 
 * 상세내용
 * - 로그인정책정보의 목록 항목을 관리한다.
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:08:55
 *  <pre>
 * == 개정이력(Modification Information) ==
 * 
 *   수정일       수정자           수정내용
 *  -------     --------    ---------------------------
 *  2009.8.3    이문준     최초 생성
 * </pre>
 */

package egovframework.com.wkp.cmu.service;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityEventVO {

	public static final String EVT_TYPE_COMMENT = "0";
	public static final String EVT_TYPE_COMMNTY_JOIN_CONFIRM = "1"; //가입 정상처리
	public static final String EVT_TYPE_COMMNTY_JOIN_REJECT = "2";//가입 거절
	public static final String EVT_TYPE_COMMNTY_MAKE_CONFIRM = "3";//개설 정상처리
	public static final String EVT_TYPE_COMMNTY_MAKE_REJECT = "4";//개설 거절
	public static final String EVT_TYPE_COMMNTY_JOIN_REQUEST = "5";//가입신청이 있음
	
	private Long eventNo;
	private String userId;
	private Date expireDtm;
	private String eventType;
	private Long cmmntyNo;
	private Long pstgNo;
	private Long commentNo;
	
	//query
	private String cmmntyNm;
	private String pstgTitle;
	private String pstgComment;
	private Date pstgDtm;
	
		
}
