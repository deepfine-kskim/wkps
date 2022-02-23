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

package egovframework.com.wkp.kno.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ErrorStatementVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private long statmntNo;
	
	private String title;
	
	private String statmntTitle;
	
	private String cont;
	
	private String answerYn;
	
	private String answerId;
	
	private Date answerDtm;
	
	private String answerDisplayName;
	
	private String answerOu;
	
	private String answerCont;
	
	private String registerId;
	
	private String displayName;
	
	private String ou;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private Integer page;
	
	private Integer itemCountPerPage = 10;
	
	private Integer itemOffset = 0;
	
	private String searchText;
	
	private Integer count;
	
	private Boolean isNew;
	
	private List<ErrorStatementVO> errorStatementList;

}
