package egovframework.com.wkp.req.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.KnowledgeVO;

import java.util.List;

public interface ReqService {

    public ListWithPageNavigation<ReqVO> selectRequestList(ReqVO reqVO);

    public int selectRequestListCount(ReqVO reqVO);
    
    public int selectRequestListCountByMine(ReqVO reqVO);
    
    public ReqVO selectRequestDetail(ReqVO reqVO);
    
    public ReqVO selectRequestPre(ReqVO reqVO);

    public ReqVO selectRequestNext(ReqVO reqVO);
    
    public long insertRequest(ReqVO reqVO);
    
    public int updateRequest(ReqVO reqVO);
    
    public int deleteRequest(ReqVO reqVO);
    
    public int updateRequestInqCnt(ReqVO reqVO);
    
    public int updateRequestAnswer(ReqVO reqVO);

    public int insertRequestAnswer(ReqVO reqVO);

    public List<ReqVO> selectAnswerList(ReqVO reqVO);

    public int updateAnswerSelection(ReqVO reqVO);

    public int insertUserRequestMileage(KnowledgeVO knowledgeVO);

    public int insertOrgRequestMileage(KnowledgeVO knowledgeVO);

    public int deleteUserRequestMileage(KnowledgeVO knowledgeVO);

    public int deleteOrgRequestMileage(KnowledgeVO knowledgeVO);
}
