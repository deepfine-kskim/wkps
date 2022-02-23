package egovframework.com.utl.fcc.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.opencsv.CSVWriter;
import egovframework.com.cmm.EgovWebUtil;

import javax.servlet.http.HttpServletRequest;

import egovframework.com.utl.sim.service.EgovFileMntrg;
import egovframework.com.utl.wed.enums.FileType;
import org.apache.commons.io.output.FileWriterWithEncoding;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * @author 공통컴포넌트 개발팀 한성곤
 * @version 1.0
 * @Class Name  : EgovFileUploadUtil.java
 * @Description : Spring 기반 File Upload 유틸리티
 * @Modification Information
 * <p>
 * 수정일                   수정자                수정내용
 * ----------     --------     ---------------------------
 * 2009.08.26     한성곤               최초 생성
 * 2018.08.17     신용호               uploadFilesExt(확장자 기록) 추가
 * 2019.12.06     신용호               checkFileExtension(), checkFileMaxSize() 추가
 * @see
 * @since 2009.08.26
 */
public class EgovFileUploadUtil extends EgovFormBasedFileUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileUploadUtil.class);
	
    /**
     * 파일을 Upload 처리한다.
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     */
    public static List<EgovFormBasedFileVo> uploadFiles(HttpServletRequest request, String where, long maxFileSize) {
        List<EgovFormBasedFileVo> list = new ArrayList<EgovFormBasedFileVo>();

        MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
        Iterator<?> fileIter = mptRequest.getFileNames();

        while (fileIter.hasNext()) {
            MultipartFile mFile = mptRequest.getFile((String) fileIter.next());

            EgovFormBasedFileVo vo = new EgovFormBasedFileVo();

            String tmp = mFile.getOriginalFilename();

            if (tmp.lastIndexOf("\\") >= 0) {
                tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
            }

            vo.setFileName(tmp);
            vo.setContentType(mFile.getContentType());
            vo.setServerSubPath(getTodayString());
            vo.setPhysicalName(getPhysicalFileName());
            vo.setSize(mFile.getSize());

            if (tmp.lastIndexOf(".") >= 0) {
                vo.setPhysicalName(vo.getPhysicalName()); // 2012.11 KISA 보안조치
            }

            if (mFile.getSize() > 0) {
                InputStream is = null;

                try {
                    is = mFile.getInputStream();
                    saveFile(is, new File(EgovWebUtil.filePathBlackList(where + SEPERATOR + vo.getServerSubPath() + SEPERATOR + vo.getPhysicalName())));
                } catch (IOException e) {
                	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
				} finally {
                    if (is != null) {
                        try {
							is.close();
						} catch (IOException e) {
							LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
						}
                    }
                }
                list.add(vo);
            }
        }

        return list;
    }

    /**
     * 파일을 Upload(확장명 저장 및 확장자 제한) 처리한다.
     *
     * @param request
     * @param where
     * @param maxFileSize
     * @return
     */
    public static List<EgovFormBasedFileVo> uploadFilesExt(HttpServletRequest request, String where, long maxFileSize, String extensionWhiteList) throws SecurityException, IOException{
        List<EgovFormBasedFileVo> list = new ArrayList<EgovFormBasedFileVo>();

        MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
        Iterator<?> fileIter = mptRequest.getFileNames();

        while (fileIter.hasNext()) {
            MultipartFile mFile = mptRequest.getFile((String) fileIter.next());

            EgovFormBasedFileVo vo = new EgovFormBasedFileVo();

            String tmp = mFile.getOriginalFilename();

            if (tmp.lastIndexOf("\\") >= 0) {
                tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
            }
            String ext = "";
            if (tmp.lastIndexOf(".") > 0)
                ext = getFileExtension(tmp).toLowerCase();
            else
                throw new SecurityException("Unacceptable file extension."); // 허용되지 않는 확장자 처리
            if (extensionWhiteList.indexOf(ext) < 0)
                throw new SecurityException("Unacceptable file extension."); // 허용되지 않는 확장자 처리

            vo.setFileName(tmp);
            vo.setContentType(mFile.getContentType());
            vo.setServerSubPath(getTodayString());
            vo.setPhysicalName(getPhysicalFileName() + "." + ext);
            vo.setSize(mFile.getSize());

            if (tmp.lastIndexOf(".") >= 0) {
                vo.setPhysicalName(vo.getPhysicalName()); // 2012.11 KISA 보안조치
            }

            if (mFile.getSize() > 0) {
                InputStream is = null;

                try {
                    is = mFile.getInputStream();
                    saveFile(is, new File(EgovWebUtil.filePathBlackList(where + SEPERATOR + vo.getServerSubPath() + SEPERATOR + vo.getPhysicalName())));
                } finally {
                    if (is != null) {
                        is.close();
                    }
                }
                list.add(vo);
            }
        }

        return list;
    }

    /**
     * 파일 확장자를 추출한다.
     *
     * @param fileNamePath
     * @return 확장자 : "" 또는 추출된 확장자
     */
    public static String getFileExtension(String fileNamePath) {

        String ext = fileNamePath.substring(fileNamePath.lastIndexOf(".") + 1, fileNamePath.length());

        return (ext == null) ? "" : ext;
    }

    /**
     * 파일 확장자의 허용유무를 검증한다.
     *
     * @param fileNamePath
     * @param whiteListExtensions : ex) .png.pdf.txt
     * @return true : 불가
     */
    public static boolean checkFileExtension(String fileNamePath, String whiteListExtensions) {
        String extension = getFileExtension(fileNamePath);

        if ("".equals(extension)) return false;

        if (whiteListExtensions == null) return false;
        if ("".equals(whiteListExtensions)) return false;

        if (whiteListExtensions.indexOf("." + extension) >= 0) return true;
        else return false;
    }

    /**
     * 최대 파일 사이즈 허용유무를 검증한다.
     *
     * @param multipartFile
     * @param maxFileSize   : ex) 1048576 = 1M , 1K = 1024
     * @return true : 불가
     */
    public static boolean checkFileMaxSize(MultipartFile multipartFile, long maxFileSize) {

        if (multipartFile == null) return false;

        if (multipartFile.getSize() <= maxFileSize) return true;
        else return false;
    }

    public static FileType getFileType(String extension) {
        String text = extension;
        if (StringUtils.isNotBlank(text)) {
            text = text.toLowerCase();

            String[] imageextension = {"jpg", "jpeg", "gif", "png", "tiff", "bmp", "img", "ico", "jfif", "exif"};
            String[] videoextension = {"asf", "avi", "flv", "mkv", "mov", "mpeg", "ogg", "mp4", "rm", "wmv", "webm", "swf"};
            String[] audioextension = {"mp3", "wav", "wma", "aac", "flac"};

            if (Arrays.stream(imageextension).anyMatch(text::equals)) {
                return FileType.IMAGE;
            }

            if (Arrays.stream(videoextension).anyMatch(text::equals)) {
                return FileType.VIDEO;
            }

            if (Arrays.stream(audioextension).anyMatch(text::equals)) {
                return FileType.AUDIO;
            }
        }

        return FileType.NONE;
    }

    /**
     * admin > loi 엑셀다운
     *
     * @throws UnsupportedEncodingException
     */
    public static void writeCsv(List<String[]> data, String filename) throws UnsupportedEncodingException {
        String fnm = new String(filename.getBytes("euc-kr"), "8859_1");
        try {
            CSVWriter cw = new CSVWriter(new FileWriterWithEncoding(fnm, "euc-kr"));
            Iterator<String[]> it = data.iterator();
            try {
                while (it.hasNext()) {
                    String[] s = it.next();
                    cw.writeNext(s);
                }

            } finally {
                cw.close();
            }
        } catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }
    }

}
