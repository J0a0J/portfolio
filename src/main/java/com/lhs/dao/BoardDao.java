package com.lhs.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.lhs.dto.BoardDto;

@Repository
public interface BoardDao {
	/**
	 * 모든 리스트 select  
	 * @param typeSeq
	 * @return
	 */
	public ArrayList<BoardDto> list(HashMap<String, String> params);
	
	/**
	 * 총 글 수 
	 * @param params
	 * @return
	 */
	
	public int existFile(BoardDto bDto);
	
	public int getTotalArticleCnt(HashMap<String, String> params);
	
	/**
	 * 글 작성 insert 
	 * @param params
	 * @return
	 */
	public int write(BoardDto bDto);
	
	/**
	 * 글 조회  
	 */
	public HashMap<String, Object> read(HashMap<String, Object> params);
	
	/**
	 * 조회수 증가.
	 * @param params
	 * @return
	 */
	public int updateHits(HashMap<String, Object> params);
	
	/**
	 * 글 수정 update 
	 * @param params
	 * @return
	 */
	public int update(HashMap<String, Object> params);
	
	/**
	 * 모든 첨부파일 삭제시 has_file = 0 으로 수정 
	 * @param params
	 * @return
	 */
	public int updateHasFileToZero(HashMap<String, Object> params);

	 
	/** 글 삭제 delete 
	 * @param params
	 * @return
	 */
	public int delete(HashMap<String, Object> params);
	
	public int deleteFile(HashMap<String, Object> params);
	
	
}