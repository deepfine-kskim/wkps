package egovframework.com.wkp.cmm.service;

import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.*;
import java.util.List;

@Component
public class Scheduler {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Scheduler.class);

	@Resource(name = "userService")
	private EgovUserService userService;
	
	@Resource(name = "orgService")
	private EgovOrgService orgService;
	
	@Resource(name = "commonService")
	private EgovCommonService commonService;
		
	@Scheduled(cron="0 5 3 * * *")
	public void userImport() {
		
		try {
			FileInputStream fstream = new FileInputStream("/data/ftp/in_user.sam");
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream, "EUC-KR"));
			
			UserVO userVO= new UserVO();
			String line;

			userService.deleteUser();

			while ((line = br.readLine()) != null) {
				String[] arr = line.split("[|]");
				userVO.setSid(arr[0]);
				userVO.setUid(arr[0]);
				userVO.setOuCode(arr[2]);
				userVO.setParentOuCode(arr[3]);
				userVO.setTopOuCode(arr[4]);
				userVO.setOu(arr[1]);
				userVO.setUserFullName(arr[7]);
				userVO.setDisplayName(arr[6]);
				userVO.setOrdr(Integer.parseInt(arr[17]));
				userVO.setPositionCode(arr[8]);
				userVO.setPosition(arr[9]);
				
				if(userVO.getSid() != null && !userVO.getSid().equals("")) {
					userService.insertUser(userVO);
				}
			}
			
			fstream.close();
			br.close();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (FileNotFoundException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (NumberFormatException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
	@Scheduled(cron="0 5 3 * * *")
	public void orgImport() {
		
		try {
			FileInputStream fstream = new FileInputStream("/data/ftp/in_org.sam");
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream, "EUC-KR"));
			
			OrgVO orgVO= new OrgVO();
			String line;
		
			while ((line = br.readLine()) != null) {
				String[] arr = line.split("[|]");
				orgVO.setOu(arr[0]);
				orgVO.setTopOuCode(arr[1]);
				orgVO.setParentOuCode(arr[2]);
				orgVO.setOuCode(arr[3]);
				orgVO.setCn(arr[3]);
				orgVO.setOrgFullName(arr[5]);
				orgVO.setOuLevel(Integer.parseInt(arr[6]));
				orgVO.setOuOrdr(Integer.parseInt(arr[7]));
				orgVO.setStatus(arr[12]);
				
				if(orgVO.getOuCode() != null && !orgVO.getOuCode().equals("") && orgVO.getOuCode().startsWith("641")) {
					orgService.insertOrg(orgVO);
				}
			}
			
			fstream.close();
			br.close();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (FileNotFoundException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (NumberFormatException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
	@Scheduled(cron="0 0 5 * * *")
	public void topMileageUser() {
		
		try {
			commonService.deleteExcellenceUser(new ExcellenceUserVO());
			List<ExcellenceUserVO> excellenceUserList = commonService.selectTopMileageUserList();
			
			for(int i = 0; i < excellenceUserList.size(); i++) {
				excellenceUserList.get(i).setRki(i+1);
				excellenceUserList.get(i).setRegisterId("admin");
				commonService.insertExcellenceUser(excellenceUserList.get(i));
			}
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
	@Scheduled(cron="0 0 5 * * *")
	public void topMileageOrg() {
		
		try {
			commonService.deleteExcellenceOrg(new ExcellenceOrgVO());
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectTopMileageOrgList();
			
			for(int i = 0; i < excellenceOrgList.size(); i++) {
				excellenceOrgList.get(i).setRki(i+1);
				excellenceOrgList.get(i).setRegisterId("admin");
				commonService.insertExcellenceOrg(excellenceOrgList.get(i));
			}
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
	@Scheduled(cron="0 0 4 * * MON")
	public void topRecommendKnowledge() {
		
		try {
			RecommendVO recommendVO = new RecommendVO();
			
			recommendVO.setKnowlgMapType("REPORT");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> reportRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);
			
			for(int i = 0; i < reportRecommendKnowledgeList.size(); i++) {
				reportRecommendKnowledgeList.get(i).setRki(i+1);
				reportRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(reportRecommendKnowledgeList.get(i));
			}
			
			recommendVO.setKnowlgMapType("REFERENCE");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> referenceRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);
			
			for(int i = 0; i < referenceRecommendKnowledgeList.size(); i++) {
				referenceRecommendKnowledgeList.get(i).setRki(i+1);
				referenceRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(referenceRecommendKnowledgeList.get(i));
			}
			
			recommendVO.setKnowlgMapType("PERSONAL");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> pesonalRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);
			
			for(int i = 0; i < pesonalRecommendKnowledgeList.size(); i++) {
				pesonalRecommendKnowledgeList.get(i).setRki(i+1);
				pesonalRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(pesonalRecommendKnowledgeList.get(i));
			}
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
	@Scheduled(cron="0 0 4 * * MON")
	public void personalizeKnowledge() {
		
		try {
			PersonalizeVO personalizeVO = new PersonalizeVO();
			
			List<OrgVO> orgList = orgService.selectOrgList(new OrgVO());
			
			for(int i = 0; i < orgList.size(); i++) {
	            OrgVO orgVO = new OrgVO();
	            orgVO.setOuCode(orgList.get(i).getOuCode());
	            String parentOuCode = orgService.selectParentOrg(orgVO).getParentOuCode();
	            
	            if(parentOuCode.equals("6410000")){
	            	parentOuCode = orgList.get(i).getOuCode();
	            } else {
	            	String tmpCode = parentOuCode;
	            	while (!tmpCode.equals("6410000")) {
	            		orgVO.setOuCode(tmpCode);
	            		tmpCode = orgService.selectParentOrg(orgVO).getParentOuCode();
	            		if(!tmpCode.equals("6410000")) {
	            			parentOuCode = tmpCode;
	            		}
	            	}
	            }
	            
				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("REPORT");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> reportPersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);
								
				for(int j = 0; j < reportPersonalizeKnowledgeList.size(); j++) {
					reportPersonalizeKnowledgeList.get(j).setRki(j+1);
					reportPersonalizeKnowledgeList.get(j).setRegisterId("admin");
					reportPersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(reportPersonalizeKnowledgeList.get(j));
				}
				
				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("REFERENCE");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> referencePersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);
				
				for(int j = 0; j < referencePersonalizeKnowledgeList.size(); j++) {
					referencePersonalizeKnowledgeList.get(j).setRki(j+1);
					referencePersonalizeKnowledgeList.get(j).setRegisterId("admin");
					referencePersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(referencePersonalizeKnowledgeList.get(j));
				}
				
				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("PERSONAL");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> pesonalPersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);
				
				for(int j = 0; j < pesonalPersonalizeKnowledgeList.size(); j++) {
					pesonalPersonalizeKnowledgeList.get(j).setRki(j+1); 
					pesonalPersonalizeKnowledgeList.get(j).setRegisterId("admin");
					pesonalPersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(pesonalPersonalizeKnowledgeList.get(j));
				}
				
			}
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}
	
}