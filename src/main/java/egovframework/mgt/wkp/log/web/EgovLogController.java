package egovframework.mgt.wkp.log.web;


import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.utl.wed.enums.SurveySearchKey;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.mgt.wkp.log.service.LogVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.Date;

@Controller
@RequestMapping("/adm/")
public class EgovLogController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogController.class);

    @Resource(name = "logService")
    EgovLogService egovLogService;

    @RequestMapping("/log.do")
    public String index(
            Model model
            , @RequestParam(value = "type", required = false) LogSubjectType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "searchKey", required = false, defaultValue = "REGISTER_ID") String searchKey
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        try {

            ListWithPageNavigation<LogVO> logList = null;

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            LogVO param = new LogVO();
            param.setPage(page);

            if (searchKey != null && StringUtils.isNotBlank(searchText)) {
                param.setSearchKey(searchKey);
                param.setSearchText(searchText);
            }

            if (type != null) {
                param.setLogSubjectType(type);
            }
            logList = egovLogService.selectLogList(param);

            int seqNum = logList.getPageNavigation().getTotalItemCount() - (page - 1) * logList.getPageNavigation().getItemCountPerPage();
            model.addAttribute("seqNum", seqNum);

            model.addAttribute("logList", logList);
            model.addAttribute("logSubjectType", LogSubjectType.values());
            model.addAttribute("logType", LogType.values());
            model.addAttribute("searchKeyTypes", SurveySearchKey.values());
            model.addAttribute("type", type);
            model.addAttribute("page", page);
            model.addAttribute("searchText", searchText);
            model.addAttribute("searchKey", searchKey);
            model.addAttribute("user", user);

            model.addAttribute("now", new Date());

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/log/EgovLog";
    }

}
