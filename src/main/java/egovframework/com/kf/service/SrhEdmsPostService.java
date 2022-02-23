package egovframework.com.kf.service;

import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import org.springframework.ui.Model;

public interface SrhEdmsPostService {
	
	public int PostSearch(ParameterVO paramVO,Model model) throws Exception;

}
