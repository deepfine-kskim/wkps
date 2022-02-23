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
    
    public ListWithPageNavigation<RequestVO> selectRequestList(RequestVO requestVO);

    public int selectRequestListCount(RequestVO requestVO);
    
    public int selectRequestListCountByMine(RequestVO requestVO);
    
    public RequestVO selectRequestDetail(RequestVO requestVO);
    
    public RequestVO selectRequestPre(RequestVO requestVO);

    public RequestVO selectRequestNext(RequestVO requestVO);
    
    public int insertRequest(RequestVO requestVO);
    
    public int updateRequest(RequestVO requestVO);
    
    public int deleteRequest(RequestVO requestVO);
    
    public int updateRequestInqCnt(RequestVO requestVO);
    
    public int updateRequestAnswer(RequestVO requestVO);
}
