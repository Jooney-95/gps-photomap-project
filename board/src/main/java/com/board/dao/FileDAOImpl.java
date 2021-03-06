package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;
import com.board.domain.UploadFiles;
import com.board.domain.LikeImgVO;

@Repository
public class FileDAOImpl implements FileDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "com.board.mappers.board";


	@Override
	public List<FileVO> viewFile(int bno) throws Exception {
		// TODO Auto-generated method stub
		
		return sql.selectList(namespace + ".viewFile", bno);
	}

	@Override
	public void modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time, String[] content) throws Exception {
		// TODO Auto-generated method stub
		UploadFiles files = new UploadFiles();
		
		FileVO[] fileVO = files.modifyFile(str_id, latitude, longitude, time, content);
		
		for(FileVO vo : fileVO) {
			sql.update(namespace + ".modifyFile", vo);
		}
		
	}

	@Override
	public void deleteFile(String[] delete) throws Exception {
		// TODO Auto-generated method stub
		UploadFiles files = new UploadFiles();
		for(String del : delete) {
			files.deleteFile(sql.selectOne(namespace + ".fileName", Integer.parseInt(del)));
			sql.delete(namespace + ".deleteFile", Integer.parseInt(del));
		}
	}

	@Override
	public void deleteFileBno(int bno) throws Exception {
		// TODO Auto-generated method stub
		UploadFiles files = new UploadFiles();
		files.deleteFileList(sql.selectList(namespace + ".fileNameList", bno));
		sql.delete(namespace + ".deleteFFB", bno);
	}

	@Override
	public void imgUpload(List<MultipartFile> file, int uesrID) throws Exception {
		// TODO Auto-generated method stub
		UploadFiles files = new UploadFiles();
		
		sql.insert(namespace + ".imgUpload", files.imgUpload(file, uesrID));
	}

	@Override
	public List<FileVO> writeFile(int userID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".writeFile", userID);
	}
	
	@Override
	public List<FileVO> modifyFile(int userID, int bno) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("userID", userID);
		map.put("bno", bno);
		return sql.selectList(namespace + ".modifyFile", map);
	}

	@Override
	public void beforeunload(int userID) throws Exception {
		// TODO Auto-generated method stub
		UploadFiles files = new UploadFiles();
		files.deleteFileList(sql.selectList(namespace + ".beforeunloadList", userID));
		
		sql.delete(namespace + ".beforeunload", userID);
	}

	@Override
	public void writeClick(HashMap<String, Object> fileMap) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".writeClick", fileMap);
	}

	@Override
	public void likeImgs(HashMap<String, Object> likeImgMap) throws Exception {
		// TODO Auto-generated method stub
	
		sql.insert(namespace + ".likeImgs", likeImgMap);
	}

	@Override
	public void deleteLikeImgs(int fileBno) throws Exception {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".deleteLikeImgs", fileBno);
	}

	@Override
	public List<LikeImgVO> selectLikeImg(int fileBno) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".selectLikeImg", fileBno);
	}

}
