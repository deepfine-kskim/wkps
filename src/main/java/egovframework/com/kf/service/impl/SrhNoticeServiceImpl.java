package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhNoticeDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhNoticeService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhNoticeService")
public class SrhNoticeServiceImpl extends EgovAbstractServiceImpl implements SrhNoticeService {
	
	/** SrhNoticeDAO */
	@Resource(name = "srhNoticeDAO")
	private SrhNoticeDAO noticeDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO NoticeSearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = noticeDAO.NoticeSearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

}
