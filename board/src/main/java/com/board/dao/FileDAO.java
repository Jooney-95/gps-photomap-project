package com.board.dao;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface FileDAO {

	public void write(List<MultipartFile> file) throws Exception;

}
