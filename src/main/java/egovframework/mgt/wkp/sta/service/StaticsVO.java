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

import java.util.List;

@Data
public class StaticsVO {

    private static final long serialVersionUID = 1L;

    private List<StaticsConnectVO> staticsConnectVoList;
    private List<StaticsQnaVO> staticsQnaVoList;
    private List<StaticsKnowledgeVO> StaticsKnowledgeVoList;

    private long totalConnectUserCount; //총 방문자수
    private long totalConnectCount; //총 방문횟수
    private long totalPreConnectUserCount; //총 전일 방문자수
    private long totalPreConnectCount; //총 전일 방문횟수

    private long totalQuestionCount; //총 Qna 작성수
    private long totalAnswerCountCount; //총 Qna 답
    private long totalPreQuestionCount; //총 Qna 작성수
    private long totalPreAnswerCountCount; //총 Qna 답변 작성수
    
    private long totalKnowledgeCount; //총 지식 작성수
    private long totalPreKnowledgeCount; //총 지식 작성수

}
