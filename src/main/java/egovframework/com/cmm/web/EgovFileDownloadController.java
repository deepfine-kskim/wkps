package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.enums.FileType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovBrowserUtil;
import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * 파일 다운로드를 위한 컨트롤러 클래스
 *
 * @author 공통서비스개발팀 이삼섭
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일      	수정자           수정내용
 *  ------------   --------    ---------------------------
 *   2009.03.25  	이삼섭          최초 생성
 *   2014.02.24		이기하          IE11 브라우저 한글 파일 다운로드시 에러 수정
 *   2018.08.28		신용호          Safari, Chrome, Firefox, Opera 한글파일 다운로드 처리 수정 (macOS에서 확장자 exe붙는 문제 처리)
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 * @since 2009.06.01
 */
@Controller
public class EgovFileDownloadController {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileDownloadController.class);

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    /**
     * 브라우저 구분 얻기.
     *
     * @param request
     * @return
     */
//    private String getBrowser(HttpServletRequest request) {
//        String header = request.getHeader("User-Agent");
//        if (header.indexOf("MSIE") > -1) {
//            return "MSIE";
//        } else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
//            return "Trident";
//        } else if (header.indexOf("Chrome") > -1) {
//            return "Chrome";
//        } else if (header.indexOf("Opera") > -1) {
//            return "Opera";
//        }
//        return "Firefox";
//    }

    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     *
     * @param commandMap
     * @param response
     * @
     */
    @RequestMapping(value = "/cmm/fms/FileDown.do")
    public void cvplFileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) {

        long atchFileNo = Long.parseLong((String) commandMap.get("atchFileNo"));
        String fileSn = (String) commandMap.get("fileSn");

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

        if (isAuthenticated) {

            FileVO fileVO = new FileVO();
            fileVO.setAtchFileNo(atchFileNo);
            fileVO.setFileSn(fileSn);
            FileVO fvo = fileService.selectFileInf(fileVO);

            File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
            long fSize = uFile.length();

            if (fSize > 0) {
                String mimetype = "application/x-msdownload";

                String userAgent = request.getHeader("User-Agent");
                HashMap<String, String> result = EgovBrowserUtil.getBrowser(userAgent);
                if (!EgovBrowserUtil.MSIE.equals(result.get(EgovBrowserUtil.TYPEKEY))) {
                    mimetype = "application/x-stuff";
                }

                String contentDisposition = EgovBrowserUtil.getDisposition(fvo.getOrignlFileNm(), userAgent, "UTF-8");
                //response.setBufferSize(fSize);	// OutOfMemeory 발생
                response.setContentType(mimetype);
                //response.setHeader("Content-Disposition", "attachment; filename=\"" + contentDisposition + "\"");
                response.setHeader("Content-Disposition", contentDisposition.replace("+", "%20"));
                response.setContentLengthLong(fSize);

                /*
                 * FileCopyUtils.copy(in, response.getOutputStream());
                 * in.close();
                 * response.getOutputStream().flush();
                 * response.getOutputStream().close();
                 */
                BufferedInputStream in = null;
                BufferedOutputStream out = null;

                try {
                    in = new BufferedInputStream(new FileInputStream(uFile));
                    out = new BufferedOutputStream(response.getOutputStream());

                    FileCopyUtils.copy(in, out);
                    out.flush();
                } catch (IOException ex) {
                    // 다음 Exception 무시 처리
                    // Connection reset by peer: socket write error
                    EgovBasicLogger.ignore("IO Exception", ex);
                } finally {
                    EgovResourceCloseHelper.close(in, out);
                }

            } else {
                response.setContentType("application/x-msdownload");

                PrintWriter printwriter = null;
				try {
					printwriter = response.getWriter();
				} catch (IOException e) {
					LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
				}

                printwriter.println("<html>");
                printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
                printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
                printwriter.println("<br><br><br>&copy; webAccess");
                printwriter.println("</html>");

                printwriter.flush();
                printwriter.close();
            }
        }
    }

    @RequestMapping(value = "/cmm/fms/upload.do", method = RequestMethod.POST)
    //public String uploadFile(
    public ModelAndView uploadFile(
            MultipartHttpServletRequest multiRequest,
            ModelMap mm) {

    	ModelAndView mav = new ModelAndView("jsonView");
    	
        List<FileVO> fileResult = new ArrayList<FileVO>();

        try {
        	Map<String, MultipartFile> files = multiRequest.getFileMap();
            System.out.println("files - " + files);
            
            
            if (!files.isEmpty()) {
            	System.out.println("----------------------------");
            	
            	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        		MultipartFile file;
        		        		
        		System.out.println("itr - " + itr);
        		while (itr.hasNext()) {
        			Entry<String, MultipartFile> entry = itr.next();
        			//System.out.println("entry - " + entry);
        			file = entry.getValue();
        			//System.out.println("file - " + file);
        			//System.out.println(file.getSize());
        			String orginFileName = file.getOriginalFilename();
        			//System.out.println("orginFileName - " + orginFileName);
        		}
            	
				//fileResult = fileUtil.parseFileIn(files, "COMM_UPLOAD_", 0, "");
        		fileResult = fileUtil.parseFileInf(files, "SRV_", 0, "");
				//System.out.println("fileResult - " + fileResult);
				fileMngService.insertFileInfs(fileResult);
				
				FileType fileType =
				EgovFileUploadUtil.getFileType(fileResult.get(0).getFileExtsn());
				fileResult.get(0).setFileType(fileType.name());
				
            }

        } catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        //Gson json = new Gson();
        //String result = json.toJson(fileResult.get(0));

        //mm.put("resultUpload", result);
        
        mav.addObject("result", fileResult);


        //return "/upload/cmm/scriptFrame";
        return mav;

    }

}
