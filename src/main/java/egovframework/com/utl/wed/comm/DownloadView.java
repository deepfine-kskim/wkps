package egovframework.com.utl.wed.comm;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

public class DownloadView extends AbstractView {
	
	public DownloadView() {
		setContentType("application/octet-stream");
	}

	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) {

		OutputStream out = null;
		FileInputStream fis = null;
		try {
			Map downloadData = (Map) model.get("downloadData");
			
			File file = (File) downloadData.get("downloadFile");
			String rname = new String(((String)downloadData.get("rname")).getBytes("euc-kr"), "8859_1");
	
			response.setContentType(DownloadUtil.getMime(DownloadUtil.getExtension(rname)));
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + rname + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			out = response.getOutputStream();		
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (IOException e) {
			logger.error("[" + e.getClass() +"] :" + e.getMessage());
			try {
				response.sendRedirect("/");
			} catch (IOException e1) {
				logger.error("[" + e.getClass() +"] :" + e.getMessage());
			}
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
				if(out != null) {
					out.flush();
				} 				
			} catch (IOException ex) {
				logger.error("[" + ex.getClass() +"] :" + ex.getMessage());
			}
		}
	}
	
}
