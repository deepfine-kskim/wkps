package egovframework.com.wkp.cmu.web;

import com.ibm.icu.util.Calendar;
import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.PageInfo;
import egovframework.com.cmm.service.*;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.kf.common.PageMaker;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.cal.service.EgovCalendarService;
import egovframework.com.wkp.cmm.service.EgovCommonService;
import egovframework.com.wkp.cmu.service.*;
import egovframework.com.wkp.cmu.service.impl.CommunityDAO;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.KnowledgeMapVO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.cmu.service.CommunityBannerVO;
import egovframework.mgt.wkp.cmu.service.EgovCommunityManageService;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.Base64.Decoder;

@Controller
@RequestMapping("/cmu")
public class EgovCommunityController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovCommunityController.class);

    @Resource(name = "communityService")
    EgovCommunityService communityService;

    @Resource(name = "communityManageService")
    EgovCommunityManageService communityManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "calendarService")
    EgovCalendarService calendarService;
    
    @Resource(name = "knowledgeService")
    private EgovKnowledgeService knowledgeService;
    
    @Resource(name = "commonService")
    private EgovCommonService commonService;

    @Resource(name = "messengerService")
    private MessengerService messengerService;

    void includeCommon(Model model, Long cmmntyNo) {
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        model.addAttribute("community", community);
        community.setMe(communityService.getCommunityMemberUser(cmmntyNo, user.getSid()));
        model.addAttribute("user", user);
        
        
        CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (mem == null) {
        	//커뮤니티회원이 아님
        	model.addAttribute("role_adm", "N");
        }else {
        	if (!(mem.getCmmntyRoleCd() != null &&
                    (
                            mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                    mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode())
                    ))) {
        		//권한이 없음(일반 회원
        		model.addAttribute("role_adm", "M");
            }else {
            	model.addAttribute("role_adm", "Y");
            }
        }
    }

    @RequestMapping("/community.do")
    public String community(@ModelAttribute("menuVO") MenuVO menuVO, Model model) {

        try {
            
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


            List<CommunityVO> listMy = communityService.selectMyCommunity(user.getSid());

            List<CommunityEventVO> listEvent = communityService.selectCommunityEvent(user.getSid());
            List<CommunityVO> listNew = communityService.selectNewCommunity();
            List<CommunityVO> listBest = communityService.selectBestCommunity();
            List<CommunityVO> listTotal = communityService.selectTotalCommunity();
            List<CommunityBannerVO> listBanner = communityManageService.findBanner("Y", null, 1000, 0);
            //List<HashMap<String,Object>> list_banner = communityService.selectCommunityBanner();

            model.addAttribute("user", user);
            model.addAttribute("list_my", listMy);
            model.addAttribute("list_event", listEvent);
            model.addAttribute("list_new", listNew);
            model.addAttribute("list_best", listBest);
            model.addAttribute("list_total", listTotal);
            model.addAttribute("list_banner", listBanner);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityList";
    }

    @RequestMapping("/communitySearch.do")
    public String communitySearch(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                  @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                  @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                  @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                  @RequestParam(value = "search_value", required = false) String searchValue
    ) {

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);


            int total = communityService.findCommunityTotalCount(searchType, searchValue);
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityVO> list = communityService.findCommunity(searchType, searchValue, limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunitySearch";
    }

    @RequestMapping("/communityRegist.do")
    public String communityRegist(@ModelAttribute("menuVO") MenuVO menuVO, Model model) {
        return "/com/wkp/cmm/EgovCommunityRegist";
    }
    
    @RequestMapping(value = "/clearEventCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView clearEventCommunity(

            @RequestParam(value = "eventNo", required = true) Long eventNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        communityService.clearCommunityEvent(eventNo);
        
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/registCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView registCommunity(

            @RequestParam(value = "cmmntyNm", required = true) String cmmntyNm,
            @RequestParam(value = "cmmntyDesc", required = true) String cmmntyDesc,
            @RequestParam(value = "memAprvYn", required = true) String memAprvYn,
            @RequestParam(value = "memPubYn", required = true) String memPubYn,
            @RequestParam(value = "keyword[]", required = false) String[] keyword

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        //private String aprvYn;
        //private Date aprvDtm;
        CommunityVO vo = new CommunityVO();
        vo.setCmmntyNm(cmmntyNm);
        vo.setCmmntyDesc(cmmntyDesc);
        vo.setMemAprvYn(memAprvYn);
        vo.setMemPubYn(memPubYn);
        vo.setAprvYn("N");
        if (keyword != null) {
            for (int i = 0; i < keyword.length; i++) {
                switch (i) {
                    case 0:
                        vo.setKeyword01(keyword[i]);
                        break;
                    case 1:
                        vo.setKeyword02(keyword[i]);
                        break;
                    case 2:
                        vo.setKeyword03(keyword[i]);
                        break;
                    case 3:
                        vo.setKeyword04(keyword[i]);
                        break;
                    case 4:
                        vo.setKeyword05(keyword[i]);
                        break;
                    case 5:
                        vo.setKeyword06(keyword[i]);
                        break;
                    case 6:
                        vo.setKeyword07(keyword[i]);
                        break;
                    case 7:
                        vo.setKeyword08(keyword[i]);
                        break;
                    case 8:
                        vo.setKeyword09(keyword[i]);
                        break;
                    case 9:
                        vo.setKeyword10(keyword[i]);
                        break;
                    default:
                        break;

                }

            }
        }

        CommunityMemberVO mem = new CommunityMemberVO();
        mem.setUserSid(user.getSid());
        mem.setCmmntyNicknm(user.getDisplayName());
        communityService.registReqCommunity(vo, mem);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityMain.do")
    public String communityMain(HttpSession session, @ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo
    ) {
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        try {
            includeCommon(model, cmmntyNo);

            model.addAttribute("notice", communityService.findCommunityNotice(cmmntyNo, null, null, 3, 0, user.getSid()));

            // 자유게시판
            model.addAttribute("free", communityService.findCommunityFreeboard(cmmntyNo, null, null, 10, 0, user.getSid()));

            // 지식게시판(자유게시판 형식)
            model.addAttribute("freeKnowledgeList", communityService.findCommunity2Freeboard(cmmntyNo, null, null, 10, 0, user.getSid()));

            //지식게시판
            KnowledgeVO knowledgeVO = new KnowledgeVO();
            knowledgeVO.setCmmntyNo(cmmntyNo);

            knowledgeVO.setPage(1);
            ListWithPageNavigation<KnowledgeVO> knowledgeList = knowledgeService.selectKnowledgeList(knowledgeVO);
            model.addAttribute("knowledgeList", knowledgeList);
            
            

            Calendar cal = Calendar.getInstance();

            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DATE);
            model.addAttribute("calendar", calendarService.selectCalendarListDayFromCommunity(year, month, day, cmmntyNo));
            
            model.addAttribute("listApply", communityService.selectCommunityApply(user.getSid(),cmmntyNo));

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityMain";
    }



    @RequestMapping(value = "/changeNickName.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView changeNickName(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "nickname", required = true) String nickname

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        if (!communityService.joinCheckNickname(cmmntyNo, nickname)) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "닉네임 중복이 있습니다.");
            mav.addObject("success", false);
            return mav;
        } else{
            CommunityMemberVO vo = new CommunityMemberVO();
            vo.setCmmntyNicknm(nickname);
            vo.setCmmntyNo(cmmntyNo);
            vo.setUserSid(user.getSid());
            communityService.updateCommunityMemberNickName(vo);
        }

        ModelAndView mav = new ModelAndView("jsonView");

        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/joinCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView joinCommunity(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "nickname", required = true) String nickname

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        System.out.println("nickname - " + nickname);
        if (nickname.isEmpty()) {
        	 ModelAndView mav = new ModelAndView("jsonView");

             mav.addObject("err_msg", "닉네임을 입력해 주세요.");
             mav.addObject("success", false);
             return mav; 
        }
        
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        //private String aprvYn;
        //private Date aprvDtm;
        int vo = communityService.getCommunityMemberExistUser(cmmntyNo, user.getSid());
        if (vo != 0) {
            /*ModelAndView mav = new ModelAndView("jsonView");
            if (vo.getAprvYn().equals("N")) {
                mav.addObject("err_msg", "이미 가입요청 되어 있습니다.");
            } else {
                mav.addObject("err_msg", "이미 가입되어 있습니다.");
            }*/

            ModelAndView mav = new ModelAndView("jsonView");
            mav.addObject("err_msg", "이미 가입되어 있습니다.");
            mav.addObject("success", false);

            return mav;
        }
        if (!communityService.joinCheckNickname(cmmntyNo, nickname)) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "닉네임 중복이 있습니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO mem = new CommunityMemberVO();
        mem.setCmmntyNo(cmmntyNo);
        mem.setUserSid(user.getSid());
        mem.setCmmntyNicknm(nickname);
        mem.setCmmntyRoleCd(null);
        if (community.getMemAprvYn() != null && community.getMemAprvYn().equals("Y")) {
            mem.setAprvYn("N");
            

        } else {
        	
        	communityService.insertCommunityEvent(user.getSid(), CommunityEventVO.EVT_TYPE_COMMNTY_JOIN_CONFIRM, cmmntyNo, -1L, -1L, -1L, -1L);
        	
            mem.setAprvYn("Y");
        }
        communityService.joinReqMember(mem);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/outCommunity.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView outCommunity(
            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo

    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "잘못된 파라메터 입니다.");
            mav.addObject("success", false);
            return mav;
        }

        CommunityMemberVO vo = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
        if (vo == null) {
            ModelAndView mav = new ModelAndView("jsonView");
            mav.addObject("err_msg", "가입된 회원이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }

        if (vo.getMberNo() == community.getOwner().getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "운영자는 탈퇴할 수 없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        communityService.deleteMember(vo.getMberNo());

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityMember.do")
    public String communityMember(HttpSession session, @ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                  @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                  @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                  @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo
    ) {

        try {
            includeCommon( model, cmmntyNo);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);


            //가입 승인이 난 회원만 보여준다.
            int total = communityService.findCommunityMemberTotalCount(cmmntyNo, null, null, "N", null);
            int limit = rows;
            int startIndex = (page - 1) * rows;

            List<CommunityMemberVO> list = communityService.findCommunityMember(cmmntyNo, null, null, "N", null, limit, startIndex);

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityMember";
    }

    @RequestMapping("/communityNoticeList.do")
    public String communityNoticeList(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                      @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                      @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                      @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                      @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                      @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            includeCommon( model, cmmntyNo);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

            int total = communityService.findCommunityNoticeTotalCount(cmmntyNo, searchType, searchValue, user.getSid());
            int limit = rows;
            int startIndex = (page - 1) * rows;

//            List<CommunityNoticeVO> list = communityService.findCommunityNotice(cmmntyNo, searchType, searchValue, limit, startIndex);
            List<CommunityNoticeVO> list = communityService.findCommunityNotice(cmmntyNo, searchType, searchValue, limit, startIndex, user.getSid());

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);
            
            int	currentPage = 1;
      		int displayNum = 10;
      		
      		PageMaker pageMaker = new PageMaker();
    		pageMaker.setPage(page);
    		pageMaker.setTotalCount(total);
    		model.addAttribute("pageMaker", pageMaker);

            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role", "N");
                }else {
                	model.addAttribute("role", "Y");	
                }
            }
            
            
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityNoticeList";
    }

    @RequestMapping("/communityNoticeView.do")
    public String communityNoticeView(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                      @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                      @RequestParam(value = "noticeNo", required = true) Long noticeNo) {

        try {
            includeCommon( model, cmmntyNo);

            CommunityNoticeVO notice = communityService.getCommunityNotice(noticeNo);
            
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            }else {
            	notice.setInqCnt(notice.getInqCnt() + 1);
            	communityService.updateCommunityNoticeInq(notice);
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role", "N");
                }else {
                	model.addAttribute("role", "Y");	
                }
            }
            
            model.addAttribute("notice", communityService.getCommunityNotice(noticeNo));
            model.addAttribute("prev", communityService.getCommunityNoticePrev(cmmntyNo, noticeNo));
            model.addAttribute("next", communityService.getCommunityNoticeNext(cmmntyNo, noticeNo));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityNoticeView";
    }

    @RequestMapping("/communityNoticeWrite.do")
    public String communityNoticeWrite(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                       @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo) {

        try {
            includeCommon( model, cmmntyNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role", "N");
            		return "redirect:/cmu/community.do";
                }else {
                	model.addAttribute("role", "Y");	
                }
            }
            
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityNoticeWrite";
    }

    public static String decode(String strDecode) {
        String decodedString = null;

        Decoder decoder = Base64.getDecoder();

        try {
            byte[] ret = decoder.decode(strDecode);
            decodedString = new String(ret, "UTF-8");
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return decodedString;
    }

    @RequestMapping(value = "/writeCommunityNotice.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunityNotice(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = false) String cont,
            @RequestParam(value = "showYn", required = false) String showYn,
            @RequestParam(value = "cmmntyNm", required = false) String cmmntyNm,
            @RequestParam(value = "link1", required = false) String link1,
            @RequestParam(value = "link2", required = false) String link2,
            @RequestParam(value = "file1", required = false) MultipartFile file1,
            @RequestParam(value = "file2", required = false) MultipartFile file2
    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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
                (
                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                ))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이 없습니다.");
            mav.addObject("success", false);
            return mav;
        }
        


	    Map<String, MultipartFile> files = new HashMap<String, MultipartFile>();
	    if (file1 != null)
	        files.put("file1", file1);
	    if (file2 != null)
	        files.put("file2", file2);
	    List<FileVO> result = new ArrayList<FileVO>();
	    
	    long atchFileNo = 0;
	    try {
	        if (!files.isEmpty()) {
	            result = fileUtil.parseFileInf(files, "CMU_NOTICE_", 0, "");
	            atchFileNo = fileMngService.insertFileInfs(result);
	        }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        CommunityNoticeVO vo = new CommunityNoticeVO();
        vo.setCmmntyNo(cmmntyNo);
        vo.setTitle(title);
        vo.setCont(decode(cont));
        vo.setShowYn(showYn);
        vo.setMberNo(mem.getMberNo());
        vo.setLink1(link1);
        vo.setLink2(link2);
        vo.setAtchFileNo(atchFileNo);
        communityService.insertCommunityNotice(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);

        UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        /* 메신저 알림 전송 */
        MessengerVO messengerVO = new MessengerVO();
//        메세지 보내는 사람 이름 : 여기선 글 작성자
        messengerVO.setSndUser(userVO.getDisplayName());
        messengerVO.setDocTitle("[도정지식포털 커뮤니티 알림]");
        messengerVO.setDocDesc("[도정지식포털 커뮤니티 "+ cmmntyNm +"] 새로운 글이 등록되었습니다.");
        messengerVO.setDocUrl("http://105.0.1.229/cmu/communityMain.do?cmmntyNo=" + cmmntyNo);

//      현재 로그인한사람 제외한 커뮤니티 멤버에게 전송
        List<CommunityMemberVO> cmmMem = communityService.getCommunityMemberByCommNo(cmmntyNo, user.getSid());

        for(CommunityMemberVO memVo : cmmMem){
//        받는사람 id 여기선 커뮤니티 회원들
            messengerVO.setRecvId(memVo.getUserSid());
            messengerService.insert(messengerVO);
        }


        return mav;
    }

    @RequestMapping("/communityNoticeModify.do")
    public String communityNoticeModify(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                        @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                        @RequestParam(value = "noticeNo", required = true) Long noticeNo) {

        try {
            includeCommon( model, cmmntyNo);

            model.addAttribute("notice", communityService.getCommunityNotice(noticeNo));

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
            		//권한이 없음
            		model.addAttribute("role", "N");
            		return "redirect:/cmu/community.do";
                }else {
                	model.addAttribute("role", "Y");	
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityNoticeModify";
    }

    @RequestMapping(value = "/modifyCommunityNotice.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunityNotice(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "noticeNo", required = true) Long noticeNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = true) String cont,
            @RequestParam(value = "showYn", required = true) String showYn,
            @RequestParam(value = "link1", required = false) String link1,
            @RequestParam(value = "link2", required = false) String link2,
            @RequestParam(value = "file1", required = false) MultipartFile file1,
            final MultipartHttpServletRequest multiRequest
    ) throws IOException, EgovComException {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityNoticeVO notice = communityService.getCommunityNotice(noticeNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || notice == null) {
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
                (
                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                ))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이 없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        List<FileVO> file = new ArrayList<FileVO>();
        
        //System.out.println("free - " + free);
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
	    List<MultipartFile> mFiles = multiRequest.getFiles("file1");
	    files.clear();
	        
	    //System.out.println("mFiles - " + mFiles);
	      
	    long atchFileNo = 0;
        if (!mFiles.isEmpty()) {
    		//System.out.println("atchFileNo - " + free.getAtchFileNo());

    		if((Long) notice.getAtchFileNo() != null && notice.getAtchFileNo() != 0) {
    			//System.out.println("11111111111111111111");
    			
	            for(MultipartFile mFile : mFiles) {
	            	//System.out.println("mFile.getOriginalFilename() - " + mFile.getOriginalFilename());
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }
	            
	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }	            
	            
	            file = fileUtil.parseFileInfs(notice.getAtchFileNo(), files, "CMU_", 0, "");
	            //System.out.println("file - " + file);
	            fileMngService.updateFileInfs(file);
	            //atchFileNo = fileMngService.insertFileInfs(file);
	            //System.out.println("atchFileNo2 - " + atchFileNo);
	            //free.setAtchFileNo(atchFileNo);
        	} else {
        		//System.out.println("2222222222222222222");
	            for(MultipartFile mFile : mFiles) {
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }
	            
	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }
	            file = fileUtil.parseFileInf(files, "CMU_", 0, "");
	            atchFileNo = fileMngService.insertFileInfs(file);
	            notice.setAtchFileNo(atchFileNo);
        	}
        }

        notice.setTitle(title);
        notice.setCont(decode(cont));
        notice.setShowYn(showYn);
        notice.setLink1(link1);
        notice.setLink2(link2);

        communityService.updateCommunityNotice(notice);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/deleteCommunityNotice.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteCommunityNotice(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "noticeNo[]", required = true) Long[] noticeNo
    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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
                (
                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                ))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이 없습니다.");
            mav.addObject("success", false);
            return mav;
        }

        for (Long no : noticeNo) {
            CommunityNoticeVO notice = communityService.getCommunityNotice(no);
            communityService.deleteCommunityNotice(notice);
        }


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityFreeList.do")
    public String communityFreeList(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                    @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                    @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                    @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                    @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            includeCommon(model, cmmntyNo);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);

            int total = communityService.findCommunityFreeboardTotalCount(cmmntyNo, searchType, searchValue, user.getSid());
            int limit = rows;
            int startIndex = (page - 1) * rows;
            int	currentPage = 1;
      		int displayNum = 10;
      		
      		PageMaker pageMaker = new PageMaker();
    		pageMaker.setPage(page);
    		pageMaker.setTotalCount(total);
    		model.addAttribute("pageMaker", pageMaker);
      		
      		//System.out.println("pageMaker - " + pageMaker);
            // 쿼리에 limit #{firstIndex}, #{lastIndex} 형태로 조회
            //페이징 영역

            List<CommunityFreeboardVO> list = communityService.findCommunityFreeboard(cmmntyNo, searchType, searchValue, limit, startIndex, user.getSid());
                        
            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("pageMaker", pageMaker);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);

            
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
                //커뮤니티회원이 아님
                model.addAttribute("role", "N");
            }else {
                if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
                    //권한이 없음
                    model.addAttribute("role", "M");
                }else {
                    model.addAttribute("role", "Y");
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityFreeList";
    }

    @RequestMapping("/community2FreeList.do")
    public String communityFree2List(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                    @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                    @RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
                                    @RequestParam(value = "search_type", required = false, defaultValue = "01") String searchType,
                                    @RequestParam(value = "search_value", required = false) String searchValue) {

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            includeCommon(model, cmmntyNo);

            model.addAttribute("page", page);
            model.addAttribute("rows", rows);
            model.addAttribute("search_type", searchType);
            model.addAttribute("search_value", searchValue);

            int total = communityService.findCommunity2FreeboardTotalCount(cmmntyNo, searchType, searchValue, user.getSid());
            int limit = rows;
            int startIndex = (page - 1) * rows;
            int	currentPage = 1;
      		int displayNum = 10;

      		PageMaker pageMaker = new PageMaker();
    		pageMaker.setPage(page);
    		pageMaker.setTotalCount(total);
    		model.addAttribute("pageMaker", pageMaker);

      		//System.out.println("pageMaker - " + pageMaker);
            // 쿼리에 limit #{firstIndex}, #{lastIndex} 형태로 조회
            //페이징 영역

            List<CommunityFreeboardVO> list = communityService.findCommunity2Freeboard(cmmntyNo, searchType, searchValue, limit, startIndex, user.getSid());

            PageInfo pi = new PageInfo(total, rows, 10, page);
            model.addAttribute("pageMaker", pageMaker);
            model.addAttribute("total_count", total);
            model.addAttribute("total_page", pi.getTotalPage());
            model.addAttribute("list", list);


            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
                //커뮤니티회원이 아님
                model.addAttribute("role", "N");
            }else {
                if (!(mem.getCmmntyRoleCd() != null &&
                        (
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                        ))) {
                    //권한이 없음
                    model.addAttribute("role", "M");
                }else {
                    model.addAttribute("role", "Y");
                }
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunity2FreeList";
    }

    @RequestMapping("/communityFreeView.do")
    public String communityFreeView(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                    @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                    @RequestParam(value = "pstgNo", required = true) Long pstgNo) {

        try {
            includeCommon( model, cmmntyNo);
            CommunityFreeboardVO free =communityService.getCommunityFreeboard(pstgNo); 

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            }else {
            	
            	//본인 작성글 확인
            	free.setInqCnt(free.getInqCnt() + 1);
            	communityService.updateCommunityFreeboardInq(free);
            	if (free.getMberNo() != mem.getMberNo()) {
                    if(mem.getCmmntyRoleCd() != null && (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode()))){
                        model.addAttribute("role", "A");
                    } else{
                        model.addAttribute("role", "M");
                    }
                }else {
                	model.addAttribute("role", "Y");	
                }
            	
            	model.addAttribute("myMebrNo", mem.getMberNo());
            	
            }
            
            model.addAttribute("free", free);
            model.addAttribute("prev", communityService.getCommunityFreeboardPrev(cmmntyNo, pstgNo, user.getSid()));
            model.addAttribute("next", communityService.getCommunityFreeboardNext(cmmntyNo, pstgNo, user.getSid()));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityFreeView";
    }

    @RequestMapping("/community2FreeView.do")
    public String community2FreeView(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                    @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                    @RequestParam(value = "pstgNo", required = true) Long pstgNo) {

        try {
            includeCommon( model, cmmntyNo);
            CommunityFreeboardVO free =communityService.getCommunity2Freeboard(pstgNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            }else {

                //본인 작성글 확인
                free.setInqCnt(free.getInqCnt() + 1);
                communityService.updateCommunity2FreeboardInq(free);
                if (free.getMberNo() != mem.getMberNo()) {
                    if(mem.getCmmntyRoleCd() != null && (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode()))){
                        model.addAttribute("role", "A");
                    } else{
                        model.addAttribute("role", "M");
                    }
                }else {
                    model.addAttribute("role", "Y");
                }

                model.addAttribute("myMebrNo", mem.getMberNo());

            }

            model.addAttribute("free", free);
            model.addAttribute("prev", communityService.getCommunity2FreeboardPrev(cmmntyNo, pstgNo, user.getSid()));
            model.addAttribute("next", communityService.getCommunity2FreeboardNext(cmmntyNo, pstgNo, user.getSid()));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunity2FreeView";
    }

    @RequestMapping(value = "/writeCommunityComment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunityComment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo,
            @RequestParam(value = "comment", required = true) String comment

    ) {
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        
        System.out.println("cmmntyNo - " + cmmntyNo);
        System.out.println("pstgNo - " + pstgNo);
        System.out.println("comment - " + comment);

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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

        CommunityCommentVO vo = new CommunityCommentVO();
        vo.setCmmntyNo(cmmntyNo);
        vo.setPstgNo(pstgNo);
        vo.setComment(comment);
        vo.setMberNo(mem.getMberNo());
        communityService.insertCommunityComment(vo);

        //이벤트 추가
        CommunityFreeboardVO board = communityService.getCommunityFreeboard(pstgNo);
        if(board != null) {
        	CommunityMemberVO board_writer = communityService.getCommunityMember(board.getMberNo());
        	if(board_writer != null) {
        		communityService.insertCommunityEvent(board_writer.getUserSid(), CommunityEventVO.EVT_TYPE_COMMENT, cmmntyNo, pstgNo, vo.getCommentNo(), -1L, -1L);
        	}
        }
        
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/writeCommunity2Comment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunity2Comment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo,
            @RequestParam(value = "comment", required = true) String comment

    ) {
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        System.out.println("cmmntyNo - " + cmmntyNo);
        System.out.println("pstgNo - " + pstgNo);
        System.out.println("comment - " + comment);

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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

        CommunityCommentVO vo = new CommunityCommentVO();
        vo.setCmmntyNo(cmmntyNo);
        vo.setPstgNo(pstgNo);
        vo.setComment(comment);
        vo.setMberNo(mem.getMberNo());
        communityService.insertCommunity2Comment(vo);

        //이벤트 추가
        CommunityFreeboardVO board = communityService.getCommunity2Freeboard(pstgNo);
        if(board != null) {
        	CommunityMemberVO board_writer = communityService.getCommunityMember(board.getMberNo());
        	if(board_writer != null) {
        		communityService.insertCommunityEvent(board_writer.getUserSid(), CommunityEventVO.EVT_TYPE_COMMENT2, cmmntyNo, -1L, -1L, pstgNo, vo.getCommentNo());
        	}
        }

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/deleteCommunityComment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteCommunityComment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "commentNo", required = true) Long commentNo

    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityCommentVO comment = communityService.getCommunityComment(commentNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || comment == null) {
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

        if (comment.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }


        communityService.deleteCommunityComment(comment);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/deleteCommunity2Comment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteCommunity2Comment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "commentNo", required = true) Long commentNo

    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityCommentVO comment = communityService.getCommunity2Comment(commentNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || comment == null) {
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

        if (comment.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }


        communityService.deleteCommunity2Comment(comment);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }
    @RequestMapping(value = "/updateCommunityComment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView updateCommunityComment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "comment", required = true) String commentText,
            @RequestParam(value = "commentNo", required = true) Long commentNo

    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityCommentVO comment = communityService.getCommunityComment(commentNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || comment == null) {
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

        if (comment.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }

        comment.setComment(commentText);
        communityService.updateCommunityComment(comment);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/updateCommunity2Comment.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView updateCommunity2Comment(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "comment", required = true) String commentText,
            @RequestParam(value = "commentNo", required = true) Long commentNo

    ) {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityCommentVO comment = communityService.getCommunity2Comment(commentNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || comment == null) {
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

        if (comment.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }

        comment.setComment(commentText);
        communityService.updateCommunity2Comment(comment);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityFreeWrite.do")
    public String communityFreeWrite(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                     @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo) {

        try {
            includeCommon( model, cmmntyNo);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityFreeWrite";
    }

    @RequestMapping("/community2FreeWrite.do")
    public String community2FreeWrite(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                     @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo) {

        try {
            includeCommon( model, cmmntyNo);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunity2FreeWrite";
    }
    
    @RequestMapping(value = "/writeCommunityFree.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunityFree(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = true) String cont,
            @RequestParam(value = "showYn", required = true) String showYn,
            @RequestParam(value = "cmmntyNm", required = false) String cmmntyNm,
            final MultipartHttpServletRequest multiRequest

    ) throws IOException, EgovComException {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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
        
        List<FileVO> file = new ArrayList<FileVO>();
        
        long atchFileNo = 0;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
        List<MultipartFile> mFiles = multiRequest.getFiles("file1");
        files.clear();
        
        CommunityFreeboardVO vo = new CommunityFreeboardVO();
        
        if (!mFiles.isEmpty()) {
        	
            for(MultipartFile mFile : mFiles) {
            	files.put(mFile.getOriginalFilename(), mFile);
            }
            
            Iterator<String> mapIter = files.keySet().iterator();
            while(mapIter.hasNext()){
                String key = mapIter.next();
                MultipartFile value = files.get(key);
                //System.out.println(key+" : " + value);
            }
            file = fileUtil.parseFileInf(files, "CMU_", 0, "");
            atchFileNo = fileMngService.insertFileInfs(file);
            vo.setAtchFileNo(atchFileNo);
        }
        
        vo.setCmmntyNo(cmmntyNo);
        vo.setTitle(title);
        vo.setCont(decode(cont));
        vo.setShowYn(showYn);
        vo.setMberNo(mem.getMberNo());

        communityService.insertCommunityFreeboard(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);

        UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        /* 메신저 알림 전송 */
        MessengerVO messengerVO = new MessengerVO();
//        메세지 보내는 사람 이름 : 여기선 글 작성자
        messengerVO.setSndUser(userVO.getDisplayName());
        messengerVO.setDocTitle("[도정지식포털 커뮤니티 알림]");
        messengerVO.setDocDesc("[도정지식포털 커뮤니티 "+ cmmntyNm +"] 새로운 글이 등록되었습니다.");
        messengerVO.setDocUrl("http://105.0.1.229/cmu/communityMain.do?cmmntyNo=" + cmmntyNo);

//      현재 로그인한사람 제외한 커뮤니티 멤버에게 전송
        List<CommunityMemberVO> cmmMem = communityService.getCommunityMemberByCommNo(cmmntyNo, user.getSid());

        for(CommunityMemberVO memVo : cmmMem){
//        받는사람 id 여기선 커뮤니티 회원들
            messengerVO.setRecvId(memVo.getUserSid());
            messengerService.insert(messengerVO);
        }

        return mav;
    }

    /* 지식게시판(자유게시판형식) 작성 */
    @RequestMapping(value = "/writeCommunity2Free.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView writeCommunity2Free(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = true) String cont,
            @RequestParam(value = "showYn", required = true) String showYn,
            @RequestParam(value = "cmmntyNm", required = false) String cmmntyNm,
            final MultipartHttpServletRequest multiRequest

    ) throws IOException, EgovComException {


        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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

        List<FileVO> file = new ArrayList<FileVO>();

        long atchFileNo = 0;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

        List<MultipartFile> mFiles = multiRequest.getFiles("file1");
        files.clear();

        CommunityFreeboardVO vo = new CommunityFreeboardVO();

        if (!mFiles.isEmpty()) {

            for(MultipartFile mFile : mFiles) {
            	files.put(mFile.getOriginalFilename(), mFile);
            }

            Iterator<String> mapIter = files.keySet().iterator();
            while(mapIter.hasNext()){
                String key = mapIter.next();
                MultipartFile value = files.get(key);
                //System.out.println(key+" : " + value);
            }
            file = fileUtil.parseFileInf(files, "CMU_", 0, "");
            atchFileNo = fileMngService.insertFileInfs(file);
            vo.setAtchFileNo(atchFileNo);
        }

        vo.setCmmntyNo(cmmntyNo);
        vo.setTitle(title);
        vo.setCont(decode(cont));
        vo.setShowYn(showYn);
        vo.setMberNo(mem.getMberNo());

        communityService.insertCommunity2Freeboard(vo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);

        UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        /* 메신저 알림 전송 */
        MessengerVO messengerVO = new MessengerVO();
//        메세지 보내는 사람 이름 : 여기선 글 작성자
        messengerVO.setSndUser(userVO.getDisplayName());
        messengerVO.setDocTitle("[도정지식포털 커뮤니티 알림]");
        messengerVO.setDocDesc("[도정지식포털 커뮤니티 "+ cmmntyNm +"] 새로운 글이 등록되었습니다.");
        messengerVO.setDocUrl("http://105.0.1.229/cmu/communityMain.do?cmmntyNo=" + cmmntyNo);

//      현재 로그인한사람 제외한 커뮤니티 멤버에게 전송
        List<CommunityMemberVO> cmmMem = communityService.getCommunityMemberByCommNo(cmmntyNo, user.getSid());

        for(CommunityMemberVO memVo : cmmMem){
//        받는사람 id 여기선 커뮤니티 회원들
            messengerVO.setRecvId(memVo.getUserSid());
            messengerService.insert(messengerVO);
        }

        return mav;
    }

    @RequestMapping("/communityFreeModify.do")
    public String communityFreeModify(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                      @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                      @RequestParam(value = "pstgNo", required = true) Long pstgNo) {

        try {
        	//System.out.println("cmmntyNo12 - " + cmmntyNo);
        	//System.out.println("pstgNo12 - " + pstgNo);
        	
            includeCommon( model, cmmntyNo);
            
            CommunityFreeboardVO free = communityService.getCommunityFreeboard(pstgNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	//본인 작성글 확인
            	if (free.getMberNo() != mem.getMberNo()) {
                    if(mem.getCmmntyRoleCd() != null && (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode()))){
                        model.addAttribute("role", "Y");
                    } else{
                        model.addAttribute("role", "M");
                        return "redirect:/cmu/community.do";
                    }
                }else {
                	model.addAttribute("role", "Y");
                }

            	model.addAttribute("myMebrNo", mem.getMberNo());
            	
            }
            
            model.addAttribute("free", free);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunityFreeModify";
    }

    /* 지식게시판(자유게시판형식) 수정 */
    @RequestMapping("/community2FreeModify.do")
    public String community2FreeModify(@ModelAttribute("menuVO") MenuVO menuVO, Model model,
                                      @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
                                      @RequestParam(value = "pstgNo", required = true) Long pstgNo) {

        try {
        	//System.out.println("cmmntyNo12 - " + cmmntyNo);
        	//System.out.println("pstgNo12 - " + pstgNo);

            includeCommon( model, cmmntyNo);

            CommunityFreeboardVO free = communityService.getCommunity2Freeboard(pstgNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityMemberVO mem = communityService.getCommunityMemberUser(cmmntyNo, user.getSid());
            if (mem == null) {
            	//커뮤니티회원이 아님
            	model.addAttribute("role", "N");
            	return "redirect:/cmu/community.do";
            }else {
            	//본인 작성글 확인
                if (free.getMberNo() != mem.getMberNo()) {
                    if(mem.getCmmntyRoleCd() != null && (mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) || mem.getCmmntyRoleCd().equals(CommunityRoleTypes.member.getCode()))){
                        model.addAttribute("role", "Y");
                    } else{
                        model.addAttribute("role", "M");
                        return "redirect:/cmu/community.do";
                    }
                }else {
                    model.addAttribute("role", "Y");
                }

                model.addAttribute("myMebrNo", mem.getMberNo());

            }

            model.addAttribute("free", free);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cmm/EgovCommunity2FreeModify";
    }

    @RequestMapping(value = "/modifyCommunityFree.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunityFree(
            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = true) String cont,
            @RequestParam(value = "showYn", required = true) String showYn,
            @RequestParam(value = "file1", required = false) MultipartFile file1,
            final MultipartHttpServletRequest multiRequest
    ) throws IOException, EgovComException {
    	
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityFreeboardVO free = communityService.getCommunityFreeboard(pstgNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || free == null) {
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

        if (free.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }
        
        
        List<FileVO> file = new ArrayList<FileVO>();
        
        //System.out.println("free - " + free);
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
	    List<MultipartFile> mFiles = multiRequest.getFiles("file1");
	    files.clear();
	        
	    //System.out.println("mFiles - " + mFiles);
	      
	    long atchFileNo = 0;
        if (!mFiles.isEmpty()) {
    		//System.out.println("atchFileNo - " + free.getAtchFileNo());

    		if((Long) free.getAtchFileNo() != null && free.getAtchFileNo() != 0) {
    			//System.out.println("11111111111111111111");
    			
	            for(MultipartFile mFile : mFiles) {
	            	//System.out.println("mFile.getOriginalFilename() - " + mFile.getOriginalFilename());
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }
	            
	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }	            
	            
	            file = fileUtil.parseFileInfs(free.getAtchFileNo(), files, "CMU_", 0, "");
	            //System.out.println("file - " + file);
	            fileMngService.updateFileInfs(file);
	            //atchFileNo = fileMngService.insertFileInfs(file);
	            //System.out.println("atchFileNo2 - " + atchFileNo);
	            //free.setAtchFileNo(atchFileNo);
        	} else {
        		//System.out.println("2222222222222222222");
	            for(MultipartFile mFile : mFiles) {
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }
	            
	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }
	            file = fileUtil.parseFileInf(files, "CMU_", 0, "");
	            atchFileNo = fileMngService.insertFileInfs(file);
	            free.setAtchFileNo(atchFileNo);
        	}
        }
	        
        free.setTitle(title);
        free.setCont(decode(cont));
        free.setShowYn(showYn);

        communityService.updateCommunityFreeboard(free);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    /* 지식게시판(자유게시판형식) 수정 */
    @RequestMapping(value = "/modifyCommunity2Free.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView modifyCommunity2Free(
            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "cont", required = true) String cont,
            @RequestParam(value = "showYn", required = true) String showYn,
            @RequestParam(value = "file1", required = false) MultipartFile file1,
            final MultipartHttpServletRequest multiRequest
    ) throws IOException, EgovComException {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        CommunityFreeboardVO free = communityService.getCommunity2Freeboard(pstgNo);
        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
        if (community == null || free == null) {
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

        if (free.getMberNo() != mem.getMberNo()) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "본인이 작성한 글이 아닙니다.");
            mav.addObject("success", false);
            return mav;
        }


        List<FileVO> file = new ArrayList<FileVO>();

        //System.out.println("free - " + free);
        final Map<String, MultipartFile> files = multiRequest.getFileMap();

	    List<MultipartFile> mFiles = multiRequest.getFiles("file1");
	    files.clear();

	    //System.out.println("mFiles - " + mFiles);

	    long atchFileNo = 0;
        if (!mFiles.isEmpty()) {
    		//System.out.println("atchFileNo - " + free.getAtchFileNo());

    		if((Long) free.getAtchFileNo() != null && free.getAtchFileNo() != 0) {
    			//System.out.println("11111111111111111111");

	            for(MultipartFile mFile : mFiles) {
	            	//System.out.println("mFile.getOriginalFilename() - " + mFile.getOriginalFilename());
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }

	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }

	            file = fileUtil.parseFileInfs(free.getAtchFileNo(), files, "CMU_", 0, "");
	            //System.out.println("file - " + file);
	            fileMngService.updateFileInfs(file);
	            //atchFileNo = fileMngService.insertFileInfs(file);
	            //System.out.println("atchFileNo2 - " + atchFileNo);
	            //free.setAtchFileNo(atchFileNo);
        	} else {
        		//System.out.println("2222222222222222222");
	            for(MultipartFile mFile : mFiles) {
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }

	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }
	            file = fileUtil.parseFileInf(files, "CMU_", 0, "");
	            atchFileNo = fileMngService.insertFileInfs(file);
	            free.setAtchFileNo(atchFileNo);
        	}
        }

        free.setTitle(title);
        free.setCont(decode(cont));
        free.setShowYn(showYn);

        communityService.updateCommunity2Freeboard(free);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }
    
    @RequestMapping(value = "/deleteCommunityFree.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteCommunityFree(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo
    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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
                (
                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                ))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이 없습니다.");
            mav.addObject("success", false);
            return mav;
        }

		/*
		 * for (Long no : pstgNo) { CommunityFreeboardVO freeboard =
		 * communityService.getCommunityFreeboard(no);
		 * communityService.deleteCommunityFreeboard(freeboard); }
		 */
        
       	CommunityFreeboardVO freeboard = communityService.getCommunityFreeboard(pstgNo);
        communityService.deleteCommunityFreeboard(freeboard);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    /* 지식게시판(자유게시판형식) 삭제 */
    @RequestMapping(value = "/deleteCommunity2Free.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteCommunity2Free(

            @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo,
            @RequestParam(value = "pstgNo", required = true) Long pstgNo
    ) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


        CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
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

/*

        if (!(mem.getCmmntyRoleCd() != null &&
                (
                        mem.getCmmntyRoleCd().equals(CommunityRoleTypes.owner.getCode()) ||
                                mem.getCmmntyRoleCd().equals(CommunityRoleTypes.board.getCode())
                ))) {
            ModelAndView mav = new ModelAndView("jsonView");

            mav.addObject("err_msg", "권한이 없습니다.");
            mav.addObject("success", false);
            return mav;
        }
*/

		/*
		 * for (Long no : pstgNo) { CommunityFreeboardVO freeboard =
		 * communityService.getCommunityFreeboard(no);
		 * communityService.deleteCommunityFreeboard(freeboard); }
		 */

       	CommunityFreeboardVO freeboard = communityService.getCommunity2Freeboard(pstgNo);
        communityService.deleteCommunity2Freeboard(freeboard);


        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping("/communityKnowledgeList.do")
    public String communityKnowledgeList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , @RequestParam(value = "cmmntyNo", required = true) Long cmmntyNo
    		, Model model) {

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            CommunityVO community = communityService.getCommunity(cmmntyNo, user.getSid());
            model.addAttribute("community", community);

            community.setMe(communityService.getCommunityMemberUser(cmmntyNo, user.getSid()));
            model.addAttribute("user", user);
            
            KnowledgeMapVO knowledgeMapVO = new KnowledgeMapVO();

            knowledgeMapVO.setKnowlgMapType("PERSONAL");
            model.addAttribute("knowlgMapType", "REPORT");
            

            if (knowledgeVO.getPage() == null || knowledgeVO.getPage() == 0) {
                knowledgeVO.setPage(1);
            }

            ListWithPageNavigation<KnowledgeVO> knowledgeList = knowledgeService.selectKnowledgeList(knowledgeVO);
            model.addAttribute("knowledgeList", knowledgeList);

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/cmm/EgovCommunityKnowledgeList";
    }

}
