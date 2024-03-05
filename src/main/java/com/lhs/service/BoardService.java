package com.lhs.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lhs.dto.BoardDto;

public interface BoardService {

	public ArrayList<BoardDto> list(HashMap<String, String> params);
	
	public int getTotalArticleCnt(HashMap<String, String> params);
	
//	public int write(HashMap<String, Object> params, List<MultipartFile> mFiles);
	public int write(BoardDto bDto, List<MultipartFile> mFiles);

	/**
	 * 글 조회  
	 */
	public BoardDto read(BoardDto bDto);
	/**
	 * 글 수정 update 
	 * @param params
	 * @return
	 */
	public int update(BoardDto bDto, List<MultipartFile> mFiles);
	
	/**첨부파일 삭제(수정 페이지에서 삭제버튼 눌러 삭제하는 경우임) 
	 * 
	 * @param params
	 * @return
	 */
	public boolean deleteAttFile(HashMap<String, Object> params);
	
	/** 글 삭제 delete 
	 * @param params
	 * @return
	 */
	public int delete(BoardDto bDto);
	

}
