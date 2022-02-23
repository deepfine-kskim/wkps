package egovframework.com.wkp.usr.web;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.rte.fdl.access.bean.AuthorityResourceMetadata;

@Controller
@RequestMapping(value = "/usr")
public class EgovUserController {

	@Resource(name = "userService")
	private EgovUserService userService;

	@Resource(name = "logService")
	EgovLogService egovLogService;
	
	@Resource(name = "authorityResource")
	AuthorityResourceMetadata authorityResource;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovUserController.class);

	/**
	 * 로그인 화면으로 들어간다
	 * @param  - 로그인후 이동할 URL이 담긴 UserVO
	 * @return 로그인 페이지
	 */
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("sid") String sid, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		// 2. 로그인 처리
		UserVO userId = new UserVO();
		userId.setSid(sid);		
		UserVO userVo = userService.selectUserDetail(userId);
		
		request.getSession().setAttribute("SSO_IDS", userVo.getSid());
		request.getSession().setAttribute("SSO_NAME", userVo.getDisplayName());
		request.getSession().setAttribute("SSO_DEPT_CODE", userVo.getOuCode());
		request.getSession().setAttribute("SSO_DEPT_NAME", userVo.getOu());
		request.getSession().setAttribute("SSO_POSITION_CODE", userVo.getPositionCode());
		
		return "redirect:/idx/index.do";
	}

	/**
	 * 로그인을 처리한다
	 * @param  - 아이디, 비밀번호가 담긴 UserVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 */
	@RequestMapping(value = "/actionLogin.do")
	public String actionLogin(HttpServletRequest request, ModelMap model) {
		
		try {
			authorityResource.reload();
		} catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		if (request.getSession().getAttribute("SSO_IDS") != null) {
			
			UserVO userVO = new UserVO();
			// SSO 세션 받아오기
			userVO.setSid((String) request.getSession().getAttribute("SSO_IDS"));
			userVO.setDisplayName((String) request.getSession().getAttribute("SSO_NAME"));
			userVO.setOuCode((String) request.getSession().getAttribute("SSO_DEPT_CODE"));
			userVO.setOu((String) request.getSession().getAttribute("SSO_DEPT_NAME"));
			userVO.setPositionCode((String) request.getSession().getAttribute("SSO_POSITION_CODE"));
			
			UserVO userDetail = userService.selectUserDetail(userVO);
			if(userDetail.getRoleCd() != null) {
				userVO.setRoleCd(userDetail.getRoleCd());	
			}
			
			if(userDetail.getNickName() != null) {
				userVO.setNickName(userDetail.getNickName());
			}
			
			// 로그인 정보를 세션에 저장
			request.getSession().setAttribute("loginVO", userVO);
			request.getSession().setAttribute("accessUser", userVO.getSid());

			egovLogService.insert(LogType.LOGIN, LogSubjectType.LOGIN, userVO);

			return "redirect:/idx/index.do";

		} else {
			return "redirect:http://105.0.1.136"; //운영
			//return "redirect:/ssoLogin.jsp"; //개발
		}
	}

	/**
	 * 로그아웃한다.
	 * @return String
	 */
	@RequestMapping(value = "/logout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) {

		/*String userIp = EgovClntInfo.getClntIP(request);*/
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		egovLogService.insert(LogType.LOGOUT, LogSubjectType.LOGIN, user);
		request.getSession().setAttribute("loginVO", null);

		return "redirect:http://105.0.1.136"; //운영
		//return "redirect:/ssoLogin.jsp"; //개발
	}
	
	@RequestMapping(value = "/userList.do")
	public ModelAndView userList(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			List<UserVO> userList = userService.selectUserList(userVO);
			mav.addObject("userList", userList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectUserRoleCheck.do")
	public int userRoleIdCheck(@ModelAttribute("userVO") UserVO userVO, ModelMap model) {
		
		int id_check = 0;
		
		try {
			id_check = userService.selectUserRoleCheck(userVO);
			 
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return id_check;
	}
	
	@RequestMapping(value = "/userImport.do")
	public void userImport(ModelMap model) {
		
		try {
			FileInputStream fstream = new FileInputStream("/data/ftp/in_user.sam");
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream, "EUC-KR"));
			
			UserVO userVO= new UserVO();
			String line;
		
			while ((line = br.readLine()) != null) {
				String[] arr = line.split("[|]");
				userVO.setSid(arr[0]);
				userVO.setUid(arr[0]);
				userVO.setOuCode(arr[2]);
				userVO.setParentOuCode(arr[3]);
				userVO.setTopOuCode(arr[4]);
				userVO.setOu(arr[1]);
				userVO.setUserFullName(arr[7]);
				userVO.setDisplayName(arr[6]);
				userVO.setOrdr(Integer.parseInt(arr[17]));
				userVO.setPositionCode(arr[8]);
				userVO.setPosition(arr[9]);
				
				if(userVO.getSid() != null && !userVO.getSid().equals("")) {
					userService.insertUser(userVO);	
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
	
	@RequestMapping(value = "/insertNickName.do")
	public String insertNickName(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, ModelMap model) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setSid(user.getSid());
			
			userService.insertNickName(userVO);
			request.getSession().setAttribute("nickName", userVO.getNickName());
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/myp/mypage.do";
	}
	
	@RequestMapping(value = "/insertRequestManager.do")
	public ModelAndView insertRequestManager(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO, ModelMap model) {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setSid(user.getSid());
			
			userService.insertRequestManager(userVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return mav;
	}

}