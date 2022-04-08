package egovframework.com.wkp.bbs.service.impl;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.bbs.service.EgovBbsService;
import egovframework.com.wkp.bbs.service.NoticeVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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
}
