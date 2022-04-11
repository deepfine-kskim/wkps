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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import lombok.Data;

@Data
public class CommunityFreeboardVO {

	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	
	private Long pstgNo;
	private Long cmmntyNo;
	private String title;
	private String cont;
	private Long mberNo;
	private Date registDtm;
	private String updaterId;
	private Date updDtm;
	private String delYn;
	private Long inqCnt;
	private String showYn;

	private Long atchFileNo;
	private String link1;
	private String link2;
	
	private Long totalCount;	

	private String cmmntyNicknm;
	
	private List<AtchFileVO> attach;
	private List<CommunityCommentVO> comment;
	
	public String getStrRegDate() {
		if(sdf == null) {
			sdf = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
		}
		if(registDtm == null) {
			return null;
		}
		
		return sdf.format(registDtm);
	}
}
