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

package egovframework.com.wkp.qna.service;

public class RankDTO {

    private int myKnowledgeCount;
    private int myKnowledgeMileage;

    private int myAnswerCount;
    private int myQuestionCount;
    private int myAnswerSelectionCount;
    private double answerSelectionPercent;

    public int getMyKnowledgeCount() {
        return myKnowledgeCount;
    }

    public void setMyKnowledgeCount(int myKnowledgeCount) {
        this.myKnowledgeCount = myKnowledgeCount;
    }

    public int getMyKnowledgeMileage() {
        return myKnowledgeMileage;
    }

    public void setMyKnowledgeMileage(int myKnowledgeMileage) {
        this.myKnowledgeMileage = myKnowledgeMileage;
    }

    public int getMyAnswerCount() {
        return myAnswerCount;
    }

    public void setMyAnswerCount(int myAnswerCount) {
        this.myAnswerCount = myAnswerCount;
    }

    public int getMyQuestionCount() {
        return myQuestionCount;
    }

    public void setMyQuestionCount(int myQuestionCount) {
        this.myQuestionCount = myQuestionCount;
    }

    public int getMyAnswerSelectionCount() {
        return myAnswerSelectionCount;
    }

    public void setMyAnswerSelectionCount(int myAnswerSelectionCount) {
        this.myAnswerSelectionCount = myAnswerSelectionCount;
    }

    public double getAnswerSelectionPercent() {
        return answerSelectionPercent;
    }

    public void setAnswerSelectionPercent(double answerSelectionPercent) {
        this.answerSelectionPercent = answerSelectionPercent;
    }
}