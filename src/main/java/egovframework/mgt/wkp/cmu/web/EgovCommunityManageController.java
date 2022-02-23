package egovframework.mgt.wkp.cmu.web;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.PageInfo;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.wkp.cmu.service.CommunityEventVO;
import egovframework.com.wkp.cmu.service.CommunityMemberVO;
import egovframework.com.wkp.cmu.service.CommunityRoleTypes;
import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.com.wkp.cmu.service.EgovCommunityService;
import egovframework.com.wkp.cmu.service.impl.CommunityDAO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.cmu.service.CommunityBannerVO;
import egovframework.mgt.wkp.cmu.service.EgovCommunityManageService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EgovCommunityManageController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovCommunityManageController.class);

    @Resource(name="communityDAO")
    private CommunityDAO communityDAO;
    
    @Resource(name = "communityService")
    EgovCommunityService communityService;

    @Resource(name = "communityManageService")
    EgovCommunityManageService communityManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @RequestMapping("/adm/commRequest.do")
    public String commRequest(Model model,
                              @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                              @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                              @RequestParam(value = "search_value", required = false) String searchValue,
                              @RequestParam(value = "aprvYn", required = false) String aprvYn
    ) {
        try {
            //
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("aprvYn", aprvYn);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);


            int total = communityManageService.findCommunityTotalCount(aprvYn, searchType, searchValue);
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityVO> list = communityManageService.findCommunity(aprvYn, searchType, searchValue, limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/mgt/wkp/cmm/EgovCommunityList";

    }

    @RequestMapping("/adm/commRequestDetail.do")
    public String commRequestDetail(Model model,
                                    @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo) {
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("community", communityService.getCommunity(cmmntyNo));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/mgt/wkp/cmm/EgovCommunityDetail";

    }

    @RequestMapping(value = "/adm/aprvCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView aprvCommunity(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "aprv", required = true) String aprv,
            @RequestParam(value = "comment", required = false) String comment

    ) {


        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null || aprv == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(aprv.equals("Y") || aprv.equals("N") || aprv.equals("R"))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        //이벤트 등록
        List<CommunityMemberVO> owner = communityDAO.loadCommunityMemberByRole(cmmntyNo, CommunityRoleTypes.owner.getCode());
        for(CommunityMemberVO m : owner) {
        	if(aprv.equals("Y")) {
        		communityService.insertCommunityEvent(m.getUserSid(), CommunityEventVO.EVT_TYPE_COMMNTY_MAKE_CONFIRM, cmmntyNo, -1L, -1L);
        	}
        	if(aprv.equals("R")) {
        		communityService.insertCommunityEvent(m.getUserSid(), CommunityEventVO.EVT_TYPE_COMMNTY_MAKE_REJECT, cmmntyNo, -1L, -1L);
        	}
        }
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        String approverId = user.getSid();
        
        communityManageService.updateCommunityAprv(cmmntyNo, aprv, comment, approverId);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/adm/commBnr.do")
    public String commBnr(Model model,
                          @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                          @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                          @RequestParam(value = "useYn", required = false) String useYn,
                          @RequestParam(value = "search_value", required = false) String searchValue
    ) {
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("useYn", useYn);
            model.addAttribute("search_value", searchValue);


            int total = communityManageService.findBannerTotalCount(useYn, searchValue);
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityBannerVO> list = communityManageService.findBanner(useYn, searchValue, limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/cmm/EgovBannerList";
    }

    @RequestMapping("/adm/commBnrRegist.do")
    public String commBnrRegist(Model model) {
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/cmm/EgovBannerRegist";
    }

    @RequestMapping("/adm/commBnrModify.do")
    public String commBnrModify(Model model,
                                @RequestParam(value = "bannerNo", required = true) Long bannerNo) {
        try {
            //
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("banner", communityManageService.getBanner(bannerNo));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/cmm/EgovBannerModify";
    }

    @RequestMapping("/adm/commBnrDetail.do")
    public String commBnrDetail(Model model,
                                @RequestParam(value = "bannerNo", required = true) Long bannerNo) {
        try {
            //
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("banner", communityManageService.getBanner(bannerNo));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/cmm/EgovBannerDetail";
    }

    @RequestMapping(value = "/adm/writeCommunityBanner.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunityBanner(
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "link", required = true) String link,
            @RequestParam(value = "useYn", required = true) String useYn,
            @RequestParam(value = "etc", required = true) String etc,
            @RequestParam(value = "image", required = true) MultipartFile image
    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


        Map<String, MultipartFile> files = new HashMap<String, MultipartFile>();
        if (image != null)
            files.put("file1", image);

        List<FileVO> result = new ArrayList<FileVO>();
        long atchFileNo = 0;
        if (!files.isEmpty()) {
            try {
				result = fileUtil.parseFileInf(files, "CMU_BANNER_", 0, "");
			} catch (IOException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			} catch (EgovComException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			}
            atchFileNo = fileMngService.insertFileInfs(result);
        }


        CommunityBannerVO vo = new CommunityBannerVO();
        vo.setAtchFileNo(atchFileNo);
        vo.setTitle(title);
        vo.setLink(link);
        vo.setUseYn(useYn);
        vo.setEtc(etc);
        vo.setRegistId(user.getSid());
        communityManageService.insertBanner(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/adm/modifyCommunityBanner.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunityBanner(
            @RequestParam(value = "bannerNo", required = true) Long bannerNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "link", required = true) String link,
            @RequestParam(value = "useYn", required = true) String useYn,
            @RequestParam(value = "etc", required = true) String etc,
            @RequestParam(value = "image", required = false) MultipartFile image
    ) {


        Map<String, MultipartFile> files = new HashMap<String, MultipartFile>();
        if (image != null)
            files.put("file1", image);

        List<FileVO> result = new ArrayList<FileVO>();
        long atchFileNo = -1;
        if (!files.isEmpty()) {
            try {
				result = fileUtil.parseFileInf(files, "CMU_BANNER_", 0, "");
			} catch (IOException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			} catch (EgovComException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			}
            atchFileNo = fileMngService.insertFileInfs(result);
        }

        CommunityBannerVO vo = communityManageService.getBanner(bannerNo);

        if (atchFileNo >= 0) {
            vo.setAtchFileNo(atchFileNo);
        }

        vo.setTitle(title);
        vo.setLink(link);
        vo.setUseYn(useYn);
        vo.setEtc(etc);

        communityManageService.updateBanner(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }


    @RequestMapping(value = "/adm/deleteCommunityBanner.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunityBanner(
            @RequestParam(value = "bannerNo", required = true) Long bannerNo
    ) {


        CommunityBannerVO vo = communityManageService.getBanner(bannerNo);

        communityManageService.deleteBanner(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }
}
