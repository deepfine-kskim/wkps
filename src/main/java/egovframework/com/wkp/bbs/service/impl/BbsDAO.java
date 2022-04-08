package egovframework.com.wkp.bbs.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.bbs.service.NoticeVO;
import org.springframework.stereotype.Repository;

import java.util.List;

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
}
