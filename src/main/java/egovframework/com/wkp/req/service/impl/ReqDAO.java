package egovframework.com.wkp.req.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.bbs.service.NoticeVO;
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

	public int insertRequest(ReqVO reqVO) {
		return insert("ReqDAO.insertRequest", reqVO);
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

}
