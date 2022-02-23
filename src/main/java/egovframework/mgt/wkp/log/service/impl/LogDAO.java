package egovframework.mgt.wkp.log.service.impl;

import egovframework.mgt.wkp.log.service.LogVO;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

import java.util.List;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
@Repository("logDAO")
public class LogDAO extends EgovComAbstractDAO {
    public List<LogVO> selectList(LogVO logVO) {
        return selectList("LogDAO.selectList", logVO);
    }

    public int selectListCount(LogVO logVO) {
        return selectOne("LogDAO.selectListCount", logVO);
    }

    public int insert(LogVO logVO) {
        return insert("LogDAO.insert", logVO);
    }

}
