package egovframework.com.wkp.req.service.impl;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.qna.service.AnswerVO;
import egovframework.com.wkp.req.service.ReqService;
import egovframework.com.wkp.req.service.ReqVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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
@Service("reqService")
public class EgovReqServiceImpl extends EgovAbstractServiceImpl implements ReqService {

    @Resource(name="reqDAO")
    private ReqDAO reqDAO;

	@Resource(name = "logService")
	EgovLogService egovLogService;

	@Override
	public ListWithPageNavigation<ReqVO> selectRequestList(ReqVO reqVO) {
		
        ListWithPageNavigation<ReqVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation = new PageNavigation(selectRequestListCount(reqVO), reqVO.getPage(), null, null);
        reqVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        reqVO.setItemOffset(pageNavigation.getItemCountPerPage() * (reqVO.getPage() - 1));
        result.setList(reqDAO.selectRequestList(reqVO));
        result.setPageNavigation(pageNavigation);

		egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.REQUEST, null);

        return result;
	}

	@Override
	public int selectRequestListCount(ReqVO reqVO) {
		return reqDAO.selectRequestListCount(reqVO);
	}
	
	@Override
	public int selectRequestListCountByMine(ReqVO reqVO) {
		return reqDAO.selectRequestListCountByMine(reqVO);
	}

	@Override
	public ReqVO selectRequestDetail(ReqVO reqVO) {
		return reqDAO.selectRequestDetail(reqVO);
	}

	@Override
	public ReqVO selectRequestPre(ReqVO reqVO) {
		return reqDAO.selectRequestPre(reqVO);
	}

	@Override
	public ReqVO selectRequestNext(ReqVO reqVO) {
		return reqDAO.selectRequestNext(reqVO);
	}

	@Override
	public int insertRequest(ReqVO reqVO) {
		return reqDAO.insertRequest(reqVO);
	}

	@Override
	public int updateRequest(ReqVO reqVO) {
		return reqDAO.updateRequest(reqVO);
	}

	@Override
	public int deleteRequest(ReqVO reqVO) {
		return reqDAO.deleteRequest(reqVO);
	}

	@Override
	public int updateRequestInqCnt(ReqVO reqVO) {
		return reqDAO.updateRequestInqCnt(reqVO);
	}

	@Override
	public int updateRequestAnswer(ReqVO reqVO) {
		return reqDAO.updateRequestAnswer(reqVO);
	}

	@Override
	public int insertRequestAnswer(ReqVO reqVO) {
		return reqDAO.insertRequestAnswer(reqVO);
	}

	@Override
	public List<ReqVO> selectAnswerList(ReqVO reqVO) {
		return reqDAO.selectAnswerList(reqVO);
	}

	@Override
	public int updateAnswerSelection(ReqVO reqVO) {
		return reqDAO.updateAnswerSelection(reqVO);
	}
}
