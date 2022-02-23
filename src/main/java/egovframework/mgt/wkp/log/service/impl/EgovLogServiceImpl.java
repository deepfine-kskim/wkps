package egovframework.mgt.wkp.log.service.impl;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.mgt.wkp.log.service.LogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("logService")
public class EgovLogServiceImpl extends EgovAbstractServiceImpl implements EgovLogService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogServiceImpl.class);

    @Resource(name = "logDAO")
    private LogDAO logDAO;

    @Override
    public ListWithPageNavigation<LogVO> selectLogList(LogVO logVO) {
        ListWithPageNavigation<LogVO> result = new ListWithPageNavigation<>();

        PageNavigation pageNavigation =
                new PageNavigation(selectListCount(logVO), logVO.getPage(), null, null);
        logVO.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        logVO.setItemOffset(pageNavigation.getItemCountPerPage() * (logVO.getPage() - 1));
        result.setList(logDAO.selectList(logVO));
        result.setPageNavigation(pageNavigation);

        return result;
    }

    @Override
    public boolean insert(LogVO logVO) {
        boolean result = false;
        try {
            result = logDAO.insert(logVO) > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
        return result;
    }

    @Override
    public boolean insert(LogType logType, LogSubjectType logSubjectType, Object cont) {
        boolean result = false;
        try {
            LogVO logVO = new LogVO();
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            if(user != null) {
                logVO.setRegisterId(user.getSid());
                logVO.setLogType(logType);
                logVO.setLogSubjectType(logSubjectType);
                logVO.setUserIp(EgovHttpRequestHelper.getRequestIp());
                if(cont != null) {
                    Gson gson = new GsonBuilder().create();
                    logVO.setCont(gson.toJson(cont));
                }

                result = insert(logVO);
            }

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return result;
    }

    @Override
    public int selectListCount(LogVO logVO) {
        return logDAO.selectListCount(logVO);
    }
}
