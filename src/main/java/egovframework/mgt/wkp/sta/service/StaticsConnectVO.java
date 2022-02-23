/**
 * 개요
 * - 로그인정책에 대한 VO 클래스를 정의한다.
 * <p>
 * 상세내용
 * - 로그인정책정보의 목록 항목을 관리한다.
 *
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:08:55
 * <pre>
 * == 개정이력(Modification Information) ==
 *
 *   수정일       수정자           수정내용
 *  -------     --------    ---------------------------
 *  2009.8.3    이문준     최초 생성
 * </pre>
 */

package egovframework.mgt.wkp.sta.service;

import lombok.Data;

@Data
public class StaticsConnectVO {

    private static final long serialVersionUID = 1L;

    private String dt;
    
    private long visitUserCount; //방문자수
    private long visitCount; //방문횟수

    private long preVisitUserCount; //전일 대비 방문자수
    private long preVisitCount; //전일 대비 방문횟수

    private Integer year;
    private Integer month;
}
