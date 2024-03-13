package com.lhs.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
		
		System.out.println("PARAMS IN LIST " + params);
		// 페이지 시작할 게시글 번호 지정  
		int pageSeq = Integer.parseInt(params.get("page"));
		pageSeq = (pageSeq -1) * 10;
		
		Map<String, Integer> map = new HashMap();
		map.put("pageSeq", pageSeq);
		map.put("typeSeq", Integer.parseInt(params.get("typeSeq")));
		
		// 페이지에서 보여줄 게시글 개수 
		int pageNum = 10;
		map.put("pageNum", pageNum);
		
		return bDao.list(map);
	}
	@Override
	public int getTotalArticleCnt(HashMap<String, String> params) {
		return bDao.getTotalArticleCnt(params);
	}

	// 반복해서 사요하기에 파일만 따로 작성하는 부분 분리 
	public int writeFile(BoardDto bDto, List<MultipartFile> mFiles) {
		int totalResult = 0;
		for (MultipartFile mFile : mFiles) {
//			TODO: smart_123.pdf -> (UUID).pdf
			String origin = mFile.getOriginalFilename();
			if (origin.length() > 0) {	
				bDto.setHasFile("Y");
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
					totalResult += result;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return totalResult;
	}

	// 게시글 작성 
	@Override
	public int write(BoardDto bDto, List<MultipartFile> mFiles) {	
		//1. board DB에 글 정보등록 + hasFile 
		System.out.println("At BOARD SERVICE IMPL, BOARD DTO IS " + bDto);
		int write = bDao.write(bDto);
		System.out.println("mFILESDFSFSD" + mFiles);
		writeFile(bDto, mFiles);
		return write;
	}

	//글 조회 
	@Override
	public BoardDto read(BoardDto bDto) {
		bDao.updateHits(bDto); // 조회수 1 올리기 
		return bDao.read(bDto);
	}
	
	
	public BoardDto readAfterWriting(BoardDto bDto) {
		return bDao.readAfterWriting(bDto);
	}
	
	// 파일 다운로드 시 사용 
	@Override
	public ArrayList<FileDto> readFile(BoardDto bDto) {
		return bDao.readFile(bDto);
	}
	
	// 간략적인 정보가 아닌 파일의 전체 정보 얻어올 때 사용 
	@Override
	public FileDto getFileInfo(int fileIdx) {
		FileDto fDto = bDao.getFileInfo(fileIdx);
		
		return fDto;
	}

	@Override
	public int update(BoardDto bDto, List<MultipartFile> mFiles) {
		// 새로운 파일을 첨부 시 사용 
		if (mFiles != null) {
			writeFile(bDto, mFiles);			
		}
		// 글 수정 dao 
		return bDao.update(bDto);
	}

	// 게시글 자체를 삭제할 때 
	@Override
	public int delete(BoardDto bDto) {
		System.out.println("SERVICE IMPL DELETE         "+ bDto);

		// hasFile 값 받아오지 않고 파일 유무와 관계없이 sql 돌리는 게 효율적. 
		int result = bDao.deleteFile(bDto);
		
		return bDao.delete(bDto);
	} 

	// 게시글 수정할 때 파일만 삭제 시 사용 
	@Override
	public int deleteAttFile(FileDto fDto) {
		int result = bDao.deleteAttFile(fDto);
		// 게시물 내 파일 개수 구하기 
		int fileCount = bDao.getFileCount(fDto);
		// 파일이 없다면 게시글 내 첨부파일 없다고 바꿔야함. 
		if (fileCount == 0) {
			BoardDto tmp = new BoardDto();
			tmp.setHasFile(null);
			int t = fDto.getBoardSeq();
			tmp.setBoardSeq(t);
			
			bDao.existFile(tmp);
		}
		return result;
	}
}