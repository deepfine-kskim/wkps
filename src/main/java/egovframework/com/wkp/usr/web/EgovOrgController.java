package egovframework.com.wkp.usr.web;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;

@Controller
@RequestMapping(value = "/org")
public class EgovOrgController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovOrgController.class);

	@Resource(name = "orgService")
	private EgovOrgService orgService;

	@RequestMapping(value = "/orgList.do")
	public ModelAndView orgList(@ModelAttribute("orgVO") OrgVO orgVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		List<OrgVO> orgList = orgService.selectOrgList(orgVO);
		mav.addObject("orgList", orgList);
		return mav;
	}
	
	@RequestMapping(value = "/orgImport.do")
	public void orgImport(ModelMap model) {
		
		try {
			FileInputStream fstream = new FileInputStream("/data/ftp/in_org.sam");
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream, "EUC-KR"));
			
			OrgVO orgVO= new OrgVO();
			String line;
		
			while ((line = br.readLine()) != null) {
				String[] arr = line.split("[|]");
				orgVO.setOu(arr[0]);
				orgVO.setTopOuCode(arr[1]);
				orgVO.setParentOuCode(arr[2]);
				orgVO.setOuCode(arr[3]);
				orgVO.setCn(arr[3]);
				orgVO.setOrgFullName(arr[5]);
				orgVO.setOuLevel(Integer.parseInt(arr[6]));
				orgVO.setOuOrdr(Integer.parseInt(arr[7]));
				orgVO.setStatus(arr[12]);
				
				if(orgVO.getOuCode() != null && !orgVO.getOuCode().equals("") && orgVO.getOuCode().startsWith("641")) {
					orgService.insertOrg(orgVO);
				}
			}
			
			fstream.close();
			br.close();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (FileNotFoundException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}	
	}

}