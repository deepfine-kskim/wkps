package egovframework.com.cmm.web;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *   2016.10.13 장동한           deleteFileInf 메소드 return 방식 수정
 *
 * </pre>
 */
@Controller
public class EgovFileMngController {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    /**
     * 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @
     */
    @RequestMapping("/cmm/fms/selectFileInfs.do")
    public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model)  {
	long atchFileNo = (long)commandMap.get("param_atchFileNo");

		fileVO.setAtchFileNo(atchFileNo);
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileNo", atchFileNo);

	return "egovframework/com/cmm/fms/EgovFileList";
    }

    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @
     */
    @RequestMapping("/cmm/fms/selectFileInfsForUpdate.do")
    public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model)  {

	long atchFileNo = (long)commandMap.get("param_atchFileNo");

	fileVO.setAtchFileNo(atchFileNo);

	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "Y");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileNo", atchFileNo);

	return "egovframework/com/cmm/fms/EgovFileList";
    }

    /**
     * 첨부파일에 대한 삭제를 처리한다.
     *
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @
     */
	@ResponseBody
    @RequestMapping("/cmm/fms/deleteFileInfs.do")
    public FileVO deleteFileInf(@RequestBody FileVO fileVO) {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
		    fileService.deleteFileInf(fileVO);
		}
		
	    return fileVO;
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @
     */
    @RequestMapping("/cmm/fms/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model)  {

	long atchFileNo = (long)commandMap.get("atchFileNo");

	fileVO.setAtchFileNo(atchFileNo);
	List<FileVO> result = fileService.selectImageFileList(fileVO);

	model.addAttribute("fileList", result);

	return "egovframework/com/cmm/fms/EgovImgFileList";
    }
}
