package egovframework.mgt.wkp.log.web;


import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.mgt.wkp.log.service.LogVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("/adm/")
public class EgovLogController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLogController.class);

    @Resource(name = "logService")
    EgovLogService egovLogService;

    @RequestMapping("/log.do")
    public String index(@ModelAttribute("logVO") LogVO logVO, Model model) {
        ListWithPageNavigation<LogVO> logList = egovLogService.selectLogList(logVO);
        model.addAttribute("logList", logList);
        return "/mgt/wkp/log/EgovLog";
    }

}
