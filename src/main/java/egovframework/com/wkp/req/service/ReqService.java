package egovframework.com.wkp.req.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.bbs.service.NoticeVO;

public interface ReqService {

    public ListWithPageNavigation<ReqVO> selectRequestList(ReqVO reqVO);

    public int selectRequestListCount(ReqVO reqVO);
    
    public int selectRequestListCountByMine(ReqVO reqVO);
    
    public ReqVO selectRequestDetail(ReqVO reqVO);
    
    public ReqVO selectRequestPre(ReqVO reqVO);

    public ReqVO selectRequestNext(ReqVO reqVO);
    
    public int insertRequest(ReqVO reqVO);
    
    public int updateRequest(ReqVO reqVO);
    
    public int deleteRequest(ReqVO reqVO);
    
    public int updateRequestInqCnt(ReqVO reqVO);
    
    public int updateRequestAnswer(ReqVO reqVO);
}
