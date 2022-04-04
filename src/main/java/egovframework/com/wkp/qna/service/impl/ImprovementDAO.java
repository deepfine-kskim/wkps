package egovframework.com.wkp.qna.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.qna.service.ImprovementVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("improvementDAO")
public class ImprovementDAO extends EgovComAbstractDAO {

    /**
     * 개선요청 목록 조회
     */
    public List<ImprovementVO> selectList(ImprovementVO param) {
        return selectList("ImprovementDAO.selectList", param);
    }

    /**
     * 개선요청 건수 조회
     */
    public int count(ImprovementVO param) {
        return selectOne("ImprovementDAO.count", param);
    }

    /**
     * 개선요청 상세 조회
     */
    public ImprovementVO selectOne(ImprovementVO param) {
        return selectOne("ImprovementDAO.selectOne", param);
    }

    /**
     * 개선요청 등록
     */
    public void insert(ImprovementVO param) {
        insert("ImprovementDAO.insert", param);
    }

    /**
     * 개선요청 수정
     */
    public void update(ImprovementVO param) {
        update("ImprovementDAO.update", param);
    }

    /**
     * 개선요청 삭제
     */
    public void delete(ImprovementVO param) {
        update("ImprovementDAO.delete", param);
    }

    /**
     * 개선요청 답변 조회
     */
    public List<ImprovementVO> selectListAnswer(ImprovementVO param) {
        return selectList("ImprovementDAO.selectListAnswer", param);
    }

    /**
     * 개선요청 답변 등록
     */
    public void insertAnswer(ImprovementVO param) {
        insert("ImprovementDAO.insertAnswer", param);
    }

    /**
     * 개선요청 답변 수정
     */
    public void updateAnswer(ImprovementVO param) {
        update("ImprovementDAO.updateAnswer", param);
    }

    /**
     * 개선요청 답변 삭제
     */
    public void deleteAnswer(ImprovementVO param) {
        update("ImprovementDAO.deleteAnswer", param);
    }

    /**
     * 이전 개선요청 상세 조회
     */
    public ImprovementVO selectOnePrev(ImprovementVO param) {
        return selectOne("ImprovementDAO.selectOnePrev", param);
    }

    /**
     * 다음 개선요청 상세 조회
     */
    public ImprovementVO selectOneNext(ImprovementVO param) {
        return selectOne("ImprovementDAO.selectOneNext", param);
    }

}
