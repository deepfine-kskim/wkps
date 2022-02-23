package egovframework.com.wkp.bbs.service.impl;

import javax.annotation.Resource;

import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.mgt.wkp.log.service.EgovLogService;
import org.springframework.stereotype.Service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.wkp.bbs.service.EgovBbsService;
import egovframework.com.wkp.bbs.service.NoticeVO;
import egovframework.com.wkp.bbs.service.RequestVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
@Service("bbsService")
public class EgovBbsServiceImpl extends EgovAbstractServiceImpl implements EgovBbsService {

    @Resource(name="bbsDAO")
    private BbsDAO bbsDAO;

	@Resource(name = "logService")
	EgovLogService egovLogService;

	/**
	 *
	 * @param noticeVO
	 * @return
	 * @
	 */
	@Override
	public ListWithPageNavigation<NoticeVO> selectNoticeList(NoticeVO noticeVO) {
        
        ListWithPageNavigation<NoticeVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectNoticeListCount(noticeVO), noticeVO.getPage(), null, null);
        noticeVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        noticeVO.setItemOffset(pageNavigation.getItemCountPerPage() * (noticeVO.getPage() - 1));
        result.setList(bbsDAO.selectNoticeList(noticeVO));
        result.setPageNavigation(pageNavigation);

		egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.NOTICE, null);

        return result;
	}
	
    /**
     * 2020.10.03
     *
     * @param noticeVO
     * @return
     * @
     */
    @Override
    public int selectNoticeListCount(NoticeVO noticeVO) {
        return bbsDAO.selectNoticeListCount(noticeVO);
    }

	/**
	 *
	 * @param noticeVO
	 * @return
	 * @
	 */
	@Override
	public NoticeVO selectNoticeDetail(NoticeVO noticeVO) {
		NoticeVO vo = bbsDAO.selectNoticeDetail(noticeVO);
		if(vo != null) {
			egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.NOTICE, vo);
		}
		return vo;
	}
	
	@Override
	public NoticeVO selectNoticePre(NoticeVO noticeVO) {
        return bbsDAO.selectNoticePre(noticeVO);
	}

	@Override
	public NoticeVO selectNoticeNext(NoticeVO noticeVO) {
        return bbsDAO.selectNoticeNext(noticeVO);
	}

	@Override
	public int insertNotice(NoticeVO noticeVO) {
		egovLogService.insert(LogType.INSERT, LogSubjectType.NOTICE, noticeVO);
		return bbsDAO.insertNotice(noticeVO);
	}

	@Override
	public int updateNotice(NoticeVO noticeVO) {
		egovLogService.insert(LogType.UPDATE, LogSubjectType.NOTICE, noticeVO);
		return bbsDAO.updateNotice(noticeVO);
	}

	@Override
	public int deleteNotice(NoticeVO noticeVO) {
		egovLogService.insert(LogType.DELETE, LogSubjectType.NOTICE, noticeVO.getNoticeNo());
		return bbsDAO.deleteNotice(noticeVO);
	}

	@Override
	public int updateInqCnt(NoticeVO noticeVO) {
		return bbsDAO.updateInqCnt(noticeVO);
	}

	@Override
	public ListWithPageNavigation<RequestVO> selectRequestList(RequestVO requestVO) {
		
        ListWithPageNavigation<RequestVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectRequestListCount(requestVO), requestVO.getPage(), null, null);
        requestVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        requestVO.setItemOffset(pageNavigation.getItemCountPerPage() * (requestVO.getPage() - 1));
        result.setList(bbsDAO.selectRequestList(requestVO));
        result.setPageNavigation(pageNavigation);

		egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.REQUEST, null);

        return result;
	}

	@Override
	public int selectRequestListCount(RequestVO requestVO) {
		return bbsDAO.selectRequestListCount(requestVO);
	}
	
	@Override
	public int selectRequestListCountByMine(RequestVO requestVO) {
		return bbsDAO.selectRequestListCountByMine(requestVO);
	}

	@Override
	public RequestVO selectRequestDetail(RequestVO requestVO) {
		return bbsDAO.selectRequestDetail(requestVO);
	}

	@Override
	public RequestVO selectRequestPre(RequestVO requestVO) {
		return bbsDAO.selectRequestPre(requestVO);
	}

	@Override
	public RequestVO selectRequestNext(RequestVO requestVO) {
		return bbsDAO.selectRequestNext(requestVO);
	}

	@Override
	public int insertRequest(RequestVO requestVO) {
		return bbsDAO.insertRequest(requestVO);
	}

	@Override
	public int updateRequest(RequestVO requestVO) {
		return bbsDAO.updateRequest(requestVO);
	}

	@Override
	public int deleteRequest(RequestVO requestVO) {
		return bbsDAO.deleteRequest(requestVO);
	}

	@Override
	public int updateRequestInqCnt(RequestVO requestVO) {
		return bbsDAO.updateRequestInqCnt(requestVO);
	}

	@Override
	public int updateRequestAnswer(RequestVO requestVO) {
		return bbsDAO.updateRequestAnswer(requestVO);
	}

}
