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

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CommunityVO {

	private Long cmmntyNo;
	private String cmmntyNm;
	private String cmmntyDesc;
	private String aprvYn;
	private Date aprvDtm;
	private String memAprvYn;
	private String memPubYn;
	private String registerId;
	private Date registDtm;
	private String updaterId;
	private Date updDtm;
	private String delYn;

	private String keyword01;
	private String keyword02;
	private String keyword03;
	private String keyword04;
	private String keyword05;
	private String keyword06;
	private String keyword07;
	private String keyword08;
	private String keyword09;
	private String keyword10;
	
	private String rejectComment;
	
	private Boolean isNew;

	//나의 커뮤니티경우
	private List<CommunityFreeboardVO> listFree;
	
	//커뮤니티메인
	private CommunityMemberVO owner;
	private int memCount;
	private int noticeCount;
	private int freeCount;
	private int free2Count;
	private int knowledgeCount;
	
	private CommunityMemberVO me;
	
	private String approverId;
	private String approverName;
	private String approverOu;
	
	public String getStrKeyword() {
		String ret = "";
		if(keyword01 != null) ret += keyword01;
		if(keyword02 != null) ret += ","+keyword02;
		if(keyword03 != null) ret += ","+keyword03;
		if(keyword04 != null) ret += ","+keyword04;
		if(keyword05 != null) ret += ","+keyword05;
		if(keyword06 != null) ret += ","+keyword06;
		if(keyword07 != null) ret += ","+keyword07;
		if(keyword08 != null) ret += ","+keyword08;
		if(keyword09 != null) ret += ","+keyword09;
		if(keyword09 != null) ret += ","+keyword10;
		return ret;
	}
	
	//관리자 리스트 전용
	private String cmmntyNicknm;
		
}
