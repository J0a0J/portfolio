package com.lhs.service.impl;

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
import com.lhs.dto.FileDto;
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
	public int write(BoardDto bDto, List<MultipartFile> mFiles) {	
		//1. board DB에 글 정보등록 + hasFile 
		System.out.println("At BOARD SERVICE IMPL, BOARD DTO IS " + bDto);
		int write = bDao.write(bDto);

		for (MultipartFile mFile : mFiles) {
//			TODO: smart_123.pdf -> (UUID).pdf
			String origin = mFile.getOriginalFilename();
			if (origin.length() > 0) {	
				int r = bDao.existFile(bDto);	
				
				// 파일 확장자 
				String extension = origin.substring(origin.lastIndexOf("."));
				String fakeName = UUID.randomUUID().toString().replaceAll("-", "");
				// 변환한 이름에 확장자 붙여주기 
				fakeName += extension;
				
				// 파일 테이블에 넣을 매개변수 
				FileDto fileInfo = new FileDto();
				fileInfo.setBoardSeq(bDto.getBoardSeq());
				fileInfo.setFileName(origin);
				fileInfo.setFakeFileName(fakeName);
				fileInfo.setFileSize((int)mFile.getSize());
				fileInfo.setFileType(extension);
				fileInfo.setSaveLoc(saveLocation);

				try {
					// 파일 이름 변환 
					fileUtil.copyFile(mFile,  fakeName);
					int result = attFileDao.addAttFile(fileInfo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}

	//글 조회 
	@Override
	public BoardDto read(BoardDto bDto) {
		bDao.updateHits(bDto);
		return bDao.read(bDto);
	}

	@Override
	public int update(BoardDto bDto, List<MultipartFile> mFiles) {

		System.out.println("THIS IS BDTO IN UPDATE :    " + bDto);
		if(bDto.getHasFile().equals("Y")) { // 첨부파일 존재시 			
			// 파일 처리
		}	
		// 글 수정 dao 
		return bDao.update(bDto);
	}

	@Override
	public int delete(BoardDto bDto) {
		System.out.println("SERVICE IMPL DELETE         "+ bDto);
		if(bDto.getHasFile() != null) {			
			if((bDto.getHasFile()).equals("Y")) { // 첨부파일 있으면 		
				// 파일 처리
				System.out.println("파일이 있다면!!!!!!!!! ");
				int result = bDao.deleteFile(bDto);
			}
		}
		
		return bDao.delete(bDto);
	} 

	@Override
	public boolean deleteAttFile(HashMap<String, Object> params) {
		boolean result = false;		
		return result;
	}
}