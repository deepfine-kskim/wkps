package egovframework.com.wkp.usr.service.impl;

import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("orgService")
public class EgovOrgServiceImpl extends EgovAbstractServiceImpl implements EgovOrgService {

    @Resource(name="orgDAO")
    private OrgDAO orgDAO;

	@Override
	public List<OrgVO> selectOrgList(OrgVO orgVO) {
		return orgDAO.selectOrgList(orgVO);
	}

	@Override
	public List<OrgVO> selectTopOrgList() {
		return orgDAO.selectTopOrgList();
	}

	@Override
	public OrgVO selectOrgDetail(OrgVO orgVO) {
		return orgDAO.selectOrgDetail(orgVO);
	}
	
	@Override
	public OrgVO selectParentOrg(OrgVO orgVO) {
		return orgDAO.selectParentOrg(orgVO);
	}

	@Override
	public int insertOrg(OrgVO orgVO) {
		return orgDAO.insertOrg(orgVO);
	}

	@Override
	public int updateOrg(OrgVO orgVO) {
		return orgDAO.updateOrg(orgVO);
	}

	@Override
	public int deleteOrg(OrgVO orgVO) {
		return orgDAO.deleteOrg(orgVO);
	}

	@Override
	public OrgVO selectTopOrgByOuCode(String ouCode) {
		return orgDAO.selectTopOrgByOuCode(ouCode);
	}
}