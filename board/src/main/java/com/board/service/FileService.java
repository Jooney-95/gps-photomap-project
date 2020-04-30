package com.board.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

	public void write(List<MultipartFile> file) throws Exception;

}
