package egovframework.com.cmm.service.impl;

import java.util.Iterator;
import java.util.List;

import egovframework.com.cmm.service.FileVO;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : EgovFileMngDAO.java
 * @Description : 파일정보 관리를 위한 데이터 처리 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Repository("FileManageDAO")
public class FileManageDAO extends EgovComAbstractDAO {

	/**
	 * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
	 *
	 * @param fileList
	 * @return
	 * @
	 */
	public long insertFileInfs(List<?> fileList) {
		FileVO vo = (FileVO) fileList.get(0);
		insert("FileManageDAO.insertFileMaster", vo);
		Iterator<?> iter = fileList.iterator();
		while (iter.hasNext()) {
			FileVO subvo = (FileVO) iter.next();
			subvo.atchFileNo = vo.atchFileNo;
			insert("FileManageDAO.insertFileDetail", subvo);
		}
		return vo.getAtchFileNo();
	}

	/**
	 * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
	 *
	 * @param vo
	 * @
	 */
	public void insertFileInf(FileVO vo) {
		insert("FileManageDAO.insertFileMaster", vo);
		insert("FileManageDAO.insertFileDetail", vo);
	}

	/**
	 * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
	 *
	 * @param fileList
	 * @
	 */
	public void updateFileInfs(List<?> fileList) {
		FileVO vo;
		Iterator<?> iter = fileList.iterator();
		while (iter.hasNext()) {
			vo = (FileVO) iter.next();
			insert("FileManageDAO.insertFileDetail", vo);
		}
	}

	/**
	 * 여러 개의 파일을 삭제한다.
	 *
	 * @param fileList
	 * @
	 */
	public void deleteFileInfs(List<?> fileList) {
		Iterator<?> iter = fileList.iterator();
		FileVO vo;
		while (iter.hasNext()) {
			vo = (FileVO) iter.next();

			delete("FileManageDAO.deleteFileDetail", vo);
		}
	}

	/**
	 * 하나의 파일을 삭제한다.
	 *
	 * @param fvo
	 * @
	 */
	public void deleteFileInf(FileVO fvo) {
		delete("FileManageDAO.deleteFileDetail", fvo);
	}

	/**
	 * 파일에 대한 목록을 조회한다.
	 *
	 * @param vo
	 * @return
	 * @
	 */
	@SuppressWarnings("unchecked")
	public List<FileVO> selectFileInfs(FileVO vo) {
		return (List<FileVO>) list("FileManageDAO.selectFileList", vo);
	}

	/**
	 * 파일 구분자에 대한 최대값을 구한다.
	 *
	 * @param fvo
	 * @return
	 * @
	 */
	public int getMaxFileSN(FileVO fvo) {
		return (Integer) selectOne("FileManageDAO.getMaxFileSN", fvo);
	}

	/**
	 * 파일에 대한 상세정보를 조회한다.
	 *
	 * @param fvo
	 * @return
	 * @
	 */
	public FileVO selectFileInf(FileVO fvo) {
		return (FileVO) selectOne("FileManageDAO.selectFileInf", fvo);
	}

	public Integer selectFileDetailMax(Long atchFileNo){
		return selectOne("FileManageDAO.selectFileDetailMax", atchFileNo);
	}
	/**
	 * 전체 파일을 삭제한다.
	 *
	 * @param fvo
	 * @
	 */
	public void deleteAllFileInf(FileVO fvo) {
		update("FileManageDAO.deleteCOMTNFILE", fvo);
	}

	/**
	 * 파일명 검색에 대한 목록을 조회한다.
	 *
	 * @param vo
	 * @return
	 * @
	 */
	@SuppressWarnings("unchecked")
	public List<FileVO> selectFileListByFileNm(FileVO fvo) {
		return (List<FileVO>) list("FileManageDAO.selectFileListByFileNm", fvo);
	}

	/**
	 * 파일명 검색에 대한 목록 전체 건수를 조회한다.
	 *
	 * @param fvo
	 * @return
	 * @
	 */
	public int selectFileListCntByFileNm(FileVO fvo) {
		return (Integer) selectOne("FileManageDAO.selectFileListCntByFileNm", fvo);
	}

	/**
	 * 이미지 파일에 대한 목록을 조회한다.
	 *
	 * @param vo
	 * @return
	 * @
	 */
	@SuppressWarnings("unchecked")
	public List<FileVO> selectImageFileList(FileVO vo) {
		return (List<FileVO>) list("FileManageDAO.selectImageFileList", vo);
	}
}
