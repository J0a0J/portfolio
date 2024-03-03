package com.lhs.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lhs.dao.AttFileDao;
import com.lhs.dao.BoardDao;
import com.lhs.dto.BoardDto;
import com.lhs.service.BoardService;
import com.lhs.util.FileUtil;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired BoardDao bDao;
	@Autowired AttFileDao attFileDao;
	@Autowired FileUtil fileUtil;
	
	@Value("#{config['project.file.upload.location']}")
	private String saveLocation;
	
	
	@Override
	public ArrayList<BoardDto> list(HashMap<String, String> params) {
		return bDao.list(params);
	}

	@Override
	public int getTotalArticleCnt(HashMap<String, String> params) {
		return bDao.getTotalArticleCnt(params);
	}

	@Override
	public int write(HashMap<String, Object> params, List<MultipartFile> mFiles) {	
		//1. board DB에 글 정보등록 + hasFile 
		int write = bDao.write(params);
		for (MultipartFile mFile : mFiles) {
//			TODO: smart_123.pdf -> (UUID).pdf
			String tmp = mFile.getOriginalFilename();
			if (tmp.length() > 0) {	
				int r = bDao.existFile(params);
				System.out.println("EXIST FILE RESULT IS  			" + r);	
				System.out.println("TMP         " + tmp);
				// 파일 확장자 
				String extension = tmp.substring(tmp.lastIndexOf("."));
				String fakeName = UUID.randomUUID().toString().replaceAll("-", "");
				// 변환한 이름에 확장자 붙여주기 
				fakeName += extension;
				// 파일 테이블에 넣을 매개변수 
				HashMap<String, Object> fileInfo = params;
				params.put("fileName", mFile.getOriginalFilename());
				params.put("fakeName", fakeName);
				params.put("fileSize", mFile.getSize());
				params.put("fileType", extension);
				params.put("saveLoc", saveLocation);
				
				try {
					// 파일 이름 변환 
					fileUtil.copyFile(mFile,  fakeName);
					int result = attFileDao.addAttFile(fileInfo);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}

	//글 조회 
	@Override
	public HashMap<String, Object> read(HashMap<String, Object> params) {
		return bDao.read(params);
	}

	@Override
	public int update(HashMap<String, Object> params, List<MultipartFile> mFiles) {
		if(params.get("hasFile").equals("Y")) { // 첨부파일 존재시 			
			// 파일 처리
		}	
		// 글 수정 dao 
		return bDao.update(params);
	}

	@Override
	public int delete(HashMap<String, Object> params) {
		System.out.println("DELTE           " + params);
		System.out.println("params.get('hasFile')      " + params.get("hasFile"));
		System.out.println("params.get('has_file')      " + params.get("has_file"));
		if(params.get("has_file") != null) {			
			if(params.get("has_file").equals("Y")) { // 첨부파일 있으면 		
				// 파일 처리
				int result = bDao.deleteFile(params);
				System.out.println("File DELETE RESULT      " + result);
			}
		}
		return bDao.delete(params);
	}
	리스트에 글 나열, 글, 파일 업로드 및 삭제 

	@Override
	public boolean deleteAttFile(HashMap<String, Object> params) {
		boolean result = false;		
		return result;
	}
}