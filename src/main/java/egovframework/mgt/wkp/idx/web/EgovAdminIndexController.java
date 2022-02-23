package egovframework.mgt.wkp.idx.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EgovAdminIndexController {
	
//	private static final Logger LOGGER = LoggerFactory.getLogger(EgovAdminIndexController.class);
	
	@RequestMapping("/adm")
	public String admin(Model model) {
		return "redirect:/adm/index.do";
	}
	
	@RequestMapping("/adm/index.do")
	public String index(Model model) {
		return "/mgt/wkp/idx/EgovIndex";
	}
	
}
