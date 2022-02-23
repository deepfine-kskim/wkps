package egovframework.com.wkp.bbs.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.bbs.service.NoticeVO;
import egovframework.com.wkp.bbs.service.RequestVO;

@Repository("bbsDAO")
public class BbsDAO extends EgovComAbstractDAO {

	public List<NoticeVO> selectNoticeList(NoticeVO noticeVO)  {
    	return selectList("BbsDAO.selectNoticeList", noticeVO);
    }
	
    public int selectNoticeListCount(NoticeVO noticeVO) {
        return selectOne("BbsDAO.selectNoticeListCount", noticeVO);
    }

	public NoticeVO selectNoticeDetail(NoticeVO noticeVO) {
    	return selectOne("BbsDAO.selectNoticeDetail", noticeVO);
    }
	
    public NoticeVO selectNoticePre(NoticeVO noticeVO) {
        return selectOne("BbsDAO.selectNoticePre", noticeVO);
    }
    public NoticeVO selectNoticeNext(NoticeVO noticeVO) {
        return selectOne("BbsDAO.selectNoticeNext", noticeVO);
    }

	public int insertNotice(NoticeVO noticeVO) {
		return insert("BbsDAO.insertNotice", noticeVO);
	}

	public int updateNotice(NoticeVO noticeVO) {
		return update("BbsDAO.updateNotice", noticeVO);
	}

	public int deleteNotice(NoticeVO noticeVO) {
		return delete("BbsDAO.deleteNotice", noticeVO);
	}
	
	public int updateInqCnt(NoticeVO noticeVO) {
		return update("BbsDAO.updateInqCnt", noticeVO);
	}
	
	public List<RequestVO> selectRequestList(RequestVO requestVO) {
		return selectList("BbsDAO.selectRequestList", requestVO);
    }

	public int selectRequestListCount(RequestVO requestVO) {
		return selectOne("BbsDAO.selectRequestListCount", requestVO);
	}

	public int selectRequestListCountByMine(RequestVO requestVO) {
		return selectOne("BbsDAO.selectRequestListCountByMine", requestVO);
	}
	
	public RequestVO selectRequestDetail(RequestVO requestVO) {
		return selectOne("BbsDAO.selectRequestDetail", requestVO);
	}

	public RequestVO selectRequestPre(RequestVO requestVO) {
		return selectOne("BbsDAO.selectRequestPre", requestVO);
	}

	public RequestVO selectRequestNext(RequestVO requestVO) {
		return selectOne("BbsDAO.selectRequestNext", requestVO);
	}

	public int insertRequest(RequestVO requestVO) {
		return insert("BbsDAO.insertRequest", requestVO);
	}

	public int updateRequest(RequestVO requestVO) {
		return update("BbsDAO.updateRequest", requestVO);
	}

	public int deleteRequest(RequestVO requestVO) {
		return delete("BbsDAO.deleteRequest", requestVO);
	}
	
	public int updateRequestInqCnt(RequestVO requestVO) {
		return update("BbsDAO.updateRequestInqCnt", requestVO);
	}
	
	public int updateRequestAnswer(RequestVO requestVO) {
		return update("BbsDAO.updateRequestAnswer", requestVO);
	}

}
