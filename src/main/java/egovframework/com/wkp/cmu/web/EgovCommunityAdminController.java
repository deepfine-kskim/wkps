package egovframework.com.wkp.cmu.web;

import egovframework.com.cmm.PageInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.wkp.cmu.service.CommunityMemberVO;
import egovframework.com.wkp.cmu.service.CommunityRoleTypes;
import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.com.wkp.cmu.service.EgovCommunityService;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.mnu.service.EgovMenuService;
import egovframework.mgt.wkp.mnu.service.MenuVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/cmu/admin/")
public class EgovCommunityAdminController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovCommunityAdminController.class);

    @Resource(name = "communityService")
    EgovCommunityService communityService;

    @Resource(name = "menuService")
    EgovMenuService menuService;

    void includeCommon(MenuVO menuVO, Model model, Long cmmntyNo) {
        
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        model.addAttribute("community", community);
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        community.setMe(communityService.getCommunityMemberUser(cmmntyNo, user.getSid()));
        model.addAttribute("user", user);
        
        
        
    }

    @RequestMapping("/communityAdmin.do")
    public String communityAdmin(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                 @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo) {

        try {
            includeCommon(menuVO, model, cmmntyNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role_adm", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) 
                        ))) {
            		//권한이 없음
            		
            		if ((mem.getCmmntyRoleCd() != null &&
                            (
                                    mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode()) 
                            ))) {
            			model.addAttribute("role_adm", "N");
            		}else {
            			return "redirect:/cmu/community.do";
            		}
            		
            		
                }else {
                	model.addAttribute("role_adm", "Y");
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityAdmin";
    }

    //위임
    @RequestMapping(value = "/entrust.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView entrust(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "targetMberNo", required = true) Long targetMberNo

    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null && mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "운영자 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }


        communityService.entrust(cmmntyNo, targetMberNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    //폐쇠
    @RequestMapping(value = "/closeCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView closeCommunity(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo
    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null && mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "운영자 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }


        communityService.closeCommunity(cmmntyNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }
    //수정

    @RequestMapping(value = "/modifyCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunity(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "cmmntyNm", required = true) String cmmntyNm,
            @RequestParam(value = "cmmntyDesc", required = true) String cmmntyDesc,
            @RequestParam(value = "memAprvYn", required = true) String memAprvYn,
            @RequestParam(value = "memPubYn", required = true) String memPubYn,
            @RequestParam(value = "keyword[]", required = false) String[] keyword
    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null && mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "운영자 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }

        community.setCmmntyNm(cmmntyNm);
        community.setCmmntyDesc(cmmntyDesc);
        community.setMemAprvYn(memAprvYn);
        community.setMemPubYn(memPubYn);
        community.setKeyword01(null);
        community.setKeyword02(null);
        community.setKeyword03(null);
        community.setKeyword04(null);
        community.setKeyword05(null);
        community.setKeyword06(null);
        community.setKeyword07(null);
        community.setKeyword08(null);
        community.setKeyword09(null);
        community.setKeyword10(null);
        if (keyword != null) {
            for (int i = 0; i < keyword.length; i++) {
                switch (i) {
                    case 0:
                        community.setKeyword01(keyword[i]);
                        break;
                    case 1:
                        community.setKeyword02(keyword[i]);
                        break;
                    case 2:
                        community.setKeyword03(keyword[i]);
                        break;
                    case 3:
                        community.setKeyword04(keyword[i]);
                        break;
                    case 4:
                        community.setKeyword05(keyword[i]);
                        break;
                    case 5:
                        community.setKeyword06(keyword[i]);
                        break;
                    case 6:
                        community.setKeyword07(keyword[i]);
                        break;
                    case 7:
                        community.setKeyword08(keyword[i]);
                        break;
                    case 8:
                        community.setKeyword09(keyword[i]);
                        break;
                    case 9:
                        community.setKeyword10(keyword[i]);
                        break;
                    default:
                        break;

                }

            }
        }
        communityService.updateCommunity(community);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    //위임을 위한 멤버검색
    @RequestMapping(value = "/findOwnerMember.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView findOwnerMember(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "nickname", required = true) String nickname
    ) {

        if (nickname == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "닉네임을 입력해주세요");
            mav.addObject("success", false);
            return mav;
        }

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("list", communityService.findCommunityMember(cmmntyNo, null, nickname, "N", null, 1000, 0));
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityAdminConfirm.do")
    public String communityAdminConfirm(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                        @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                        @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                        @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                        @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            includeCommon(menuVO, model, cmmntyNo);


            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);


            int total = communityService.findCommunityMemberTotalCount(cmmntyNo, searchType, searchValue, "Y", null);
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityMemberVO> list = communityService.findCommunityMember(cmmntyNo, searchType, searchValue, "Y", null, limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);

            
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role_adm", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role_adm", "N");
            		return "redirect:/cmu/community.do";
                }else {
                	model.addAttribute("role_adm", "Y");	
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityAdminConfirm";
    }

    //승인/거절 []
    @RequestMapping(value = "/aprvMember.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView aprvMember(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "aprvYn", required = true) String aprvYn,
            @RequestParam(value = "mberNo[]", required = true) Long[] mberNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null &&
                (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이없습니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (aprvYn.equals("Y")) {
        	
            communityService.memberConfirm(mberNo);
            
        } else {
            communityService.memberReject(mberNo);
        }

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }


    @RequestMapping("/communityAdminMember.do")
    public String communityAdminMember(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                       @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                       @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                       @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                       @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                       @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            includeCommon(menuVO, model, cmmntyNo);


            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);


            int total = communityService.findCommunityMemberTotalCount(cmmntyNo, searchType, searchValue, "N", "N");
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityMemberVO> list = communityService.findCommunityMember(cmmntyNo, searchType, searchValue, "N", "N", limit, startIndex);
            communityService.setBoardCount(list);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role_adm", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role_adm", "N");
            		return "redirect:/cmu/community.do";
                }else {
                	model.addAttribute("role_adm", "Y");	
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityAdminMember";
    }

    //강제탈퇴 []
    @RequestMapping(value = "/delMember.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView delMember(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "mberNo[]", required = true) Long[] mberNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null &&
                (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        communityService.memberDelete(mberNo);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    //스텝등록 []
    @RequestMapping(value = "/staffMember.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView staffMember(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "mberNo[]", required = true) Long[] mberNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null &&
                (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        communityService.memberAddStaff(mberNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }


    @RequestMapping("/communityAdminStaff.do")
    public String communityMain(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            includeCommon(menuVO, model, cmmntyNo);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);


            int total = communityService.findCommunityMemberTotalCount(cmmntyNo, searchType, searchValue, "N", "Y");
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityMemberVO> list = communityService.findCommunityMember(cmmntyNo, searchType, searchValue, "N", "Y", limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);
            
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role_adm", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role_adm", "N");
            		return "redirect:/cmu/community.do";
                }else {
                	model.addAttribute("role_adm", "Y");	
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityAdminStaff";
    }

    //스텝삭제 []
    @RequestMapping(value = "/delStaffMember.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView delStaffMember(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "mberNo[]", required = true) Long[] mberNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null &&
                (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        communityService.memberDelStaff(mberNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    //스텝권한변경 []
    @RequestMapping(value = "/changeStaffRole.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView changeStaffRole(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "mberNo[]", required = true) Long[] mberNo,
            @RequestParam(value = "roleCd[]", required = true) String[] roleCd
    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityVO community = communityService.getCommunity(cmmntyNo);
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "커뮤니티 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        if (!(mem.getCmmntyRoleCd() != null &&
                (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        communityService.memberUpdateStaffRole(mberNo, roleCd);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

}
