package egovframework.com.wkp.bbs.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;

public interface EgovBbsService {
	
    public ListWithPageNavigation<NoticeVO> selectNoticeList(NoticeVO noticeVO);

    public int selectNoticeListCount(NoticeVO noticeVO);
    
    public NoticeVO selectNoticeDetail(NoticeVO noticeVO);
    
    public NoticeVO selectNoticePre(NoticeVO noticeVO);

    public NoticeVO selectNoticeNext(NoticeVO noticeVO);
    
    public int insertNotice(NoticeVO noticeVO);
    
    public int updateNotice(NoticeVO noticeVO);
    
    public int deleteNotice(NoticeVO noticeVO);
          
    public int updateInqCnt(NoticeVO noticeVO);
}
