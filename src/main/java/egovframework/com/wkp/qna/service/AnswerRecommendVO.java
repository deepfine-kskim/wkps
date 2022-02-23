package egovframework.com.wkp.qna.service;

import java.util.Date;

public class AnswerRecommendVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private Long recommendNo;
	private Long answerNo;
	private String registerId;
	private Date registDtm;

	private int recommendCount;
	private boolean mine;

	public Long getRecommendNo() {
		return recommendNo;
	}

	public void setRecommendNo(Long recommendNo) {
		this.recommendNo = recommendNo;
	}

	public Long getAnswerNo() {
		return answerNo;
	}

	public void setAnswerNo(Long answerNo) {
		this.answerNo = answerNo;
	}

	public String getRegisterId() {
		return registerId;
	}

	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}

	public Date getRegistDtm() {
		return registDtm;
	}

	public void setRegistDtm(Date registDtm) {
		this.registDtm = registDtm;
	}

	public int getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}

	public boolean isMine() {
		return mine;
	}

	public void setMine(boolean mine) {
		this.mine = mine;
	}
}
