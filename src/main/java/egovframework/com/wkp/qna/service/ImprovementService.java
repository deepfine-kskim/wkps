package egovframework.com.wkp.qna.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;

import java.util.List;

public interface ImprovementService {

    /**
     * 개선요청 목록 조회
     */
    ListWithPageNavigation<ImprovementVO> listWithPageNavigation(ImprovementVO param);

    /**
     * 개선요청 건수 조회
     */
    int count(ImprovementVO param);

    /**
     * 개선요청 상세 조회
     */
    ImprovementVO detail(ImprovementVO param);

    /**
     * 개선요청 등록
     */
    void insert(ImprovementVO param);

    /**
     * 개선요청 수정
     */
    void update(ImprovementVO param);

    /**
     * 개선요청 삭제
     */
    void delete(ImprovementVO param);

    /**
     * 개선요청 답변 조회
     */
    List<ImprovementVO> findAnswer(ImprovementVO param);

    /**
     * 개선요청 답변 등록
     */
    void insertAnswer(ImprovementVO param);

    /**
     * 개선요청 답변 수정
     */
    void updateAnswer(ImprovementVO param);

    /**
     * 개선요청 답변 삭제
     */
    void deleteAnswer(ImprovementVO param);

    /**
     * 이전 개선요청 상세 조회
     */
    ImprovementVO detailPrev(ImprovementVO param);

    /**
     * 다음 개선요청 상세 조회
     */
    ImprovementVO detailNext(ImprovementVO param);
}
