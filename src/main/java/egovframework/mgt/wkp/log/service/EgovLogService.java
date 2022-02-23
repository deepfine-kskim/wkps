package egovframework.mgt.wkp.log.service;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
public interface EgovLogService {

    /**
     * 2020.11.23
     * 로그 리스트를 가져온다.
     * @param logVO
     * @return
     * @
     */
    ListWithPageNavigation<LogVO> selectLogList(LogVO logVO);

    /**
     * 2020.11.23
     * 로그 리스트의 개수를 가져온다
     * @param logVO
     * @return
     * @
     */
    int selectListCount(LogVO logVO);

    /**
     *  2020.11.23
     * 로그를 등록한다.
     * @param logVO
     * @return LogVO
     * @
     */
    boolean insert(LogVO logVO);

    boolean insert(LogType logType, LogSubjectType logSubjectType,Object cont);
}
