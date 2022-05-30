package egovframework.com.wkp.usr.service;

import java.util.List;

public interface EgovOrgService {

    public List<OrgVO> selectOrgList(OrgVO orgVO);

    public List<OrgVO> selectTopOrgList();

    public OrgVO selectOrgDetail(OrgVO orgVO);
    
    public OrgVO selectParentOrg(OrgVO orgVO);

    public int insertOrg(OrgVO orgVO);

    public int updateOrg(OrgVO orgVO);

    public int deleteOrg(OrgVO orgVO);

    public OrgVO selectTopOrgByOuCode(String ouCode);
		
}
