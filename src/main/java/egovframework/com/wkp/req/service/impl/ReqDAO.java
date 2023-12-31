package egovframework.com.wkp.req.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.req.service.ReqVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("reqDAO")
public class ReqDAO extends EgovComAbstractDAO {

	public List<ReqVO> selectRequestList(ReqVO reqVO) {
		return selectList("ReqDAO.selectRequestList", reqVO);
    }

	public int selectRequestListCount(ReqVO reqVO) {
		return selectOne("ReqDAO.selectRequestListCount", reqVO);
	}

	public int selectRequestListCountByMine(ReqVO reqVO) {
		return selectOne("ReqDAO.selectRequestListCountByMine", reqVO);
	}
	
	public ReqVO selectRequestDetail(ReqVO reqVO) {
		return selectOne("ReqDAO.selectRequestDetail", reqVO);
	}

	public ReqVO selectRequestPre(ReqVO reqVO) {
		return selectOne("ReqDAO.selectRequestPre", reqVO);
	}

	public ReqVO selectRequestNext(ReqVO reqVO) {
		return selectOne("ReqDAO.selectRequestNext", reqVO);
	}

	public long insertRequest(ReqVO reqVO) {
		insert("ReqDAO.insertRequest", reqVO);
		return reqVO.getRequstNo();
	}

	public int updateRequest(ReqVO reqVO) {
		return update("ReqDAO.updateRequest", reqVO);
	}

	public int deleteRequest(ReqVO reqVO) {
		return delete("ReqDAO.deleteRequest", reqVO);
	}
	
	public int updateRequestInqCnt(ReqVO reqVO) {
		return update("ReqDAO.updateRequestInqCnt", reqVO);
	}
	
	public int updateRequestAnswer(ReqVO reqVO) {
		return update("ReqDAO.updateRequestAnswer", reqVO);
	}

	public int insertRequestAnswer(ReqVO reqVO) {
		return insert("ReqDAO.insertRequestAnswer", reqVO);
	}

	public List<ReqVO> selectAnswerList(ReqVO reqVO) {
		return selectList("ReqDAO.selectAnswerList", reqVO);
	}

	public int updateAnswerSelection(ReqVO reqVO) {
		return update("ReqDAO.updateAnswerSelection", reqVO);
	}

	public int insertUserRequestMileage(KnowledgeVO knowledgeVO) {
		return insert("ReqDAO.insertUserRequestMileage", knowledgeVO);
	}

	public int insertOrgRequestMileage(KnowledgeVO knowledgeVO) {
		return insert("ReqDAO.insertOrgRequestMileage", knowledgeVO);
	}

	public int deleteUserRequestMileage(KnowledgeVO knowledgeVO) {
		return delete("ReqDAO.deleteUserRequestMileage", knowledgeVO);
	}

	public int deleteOrgRequestMileage(KnowledgeVO knowledgeVO) {
		return delete("ReqDAO.deleteOrgRequestMileage", knowledgeVO);
	}

}
