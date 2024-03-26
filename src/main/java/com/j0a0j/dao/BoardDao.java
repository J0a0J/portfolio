package com.j0a0j.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.CommentDto;
import com.j0a0j.dto.FileDto;

@Repository
public interface BoardDao {
	/**
	 * 모든 리스트 select
	 * 
	 * @param typeSeq
	 * @return
	 */
	public ArrayList<BoardDto> list(Map<String, Integer> map);

	/**
	 * 총 글 수
	 * 
	 * @param params
	 * @return
	 */
	public int getTotalArticleCnt(HashMap<String, String> params);

	public int existFile(BoardDto bDto);

	/**
	 * 글 작성 insert
	 * 
	 * @param params
	 * @return
	 */
	public int write(BoardDto bDto);

	/**
	 * 글 조회
	 */
	public BoardDto read(BoardDto bDto);

	public BoardDto readAfterWriting(BoardDto bDto);

	public ArrayList<FileDto> readFile(BoardDto bDto);

	public FileDto getFileInfo(int fileIdx);

	/**
	 * 댓글 작성
	 * 
	 * @param cDto
	 * @return
	 */
	public int writeComment(CommentDto cDto);

	/**
	 * 댓글 불러오기
	 * 
	 * @param boardSeq
	 * @return
	 */
	public ArrayList<CommentDto> readComment(int boardSeq);

	/**
	 * 조회수 증가.
	 * 
	 * @param params
	 * @return
	 */
	public int updateHits(BoardDto bDto);

	/**
	 * 글 수정 update
	 * 
	 * @param params
	 * @return
	 */
	public int update(BoardDto bDto);

	/**
	 * 모든 첨부파일 삭제시 has_file = 0 으로 수정
	 * 
	 * @param params
	 * @return
	 */
	public int updateHasFileToZero(HashMap<String, Object> params);

	/**
	 * 글 삭제 delete
	 * 
	 * @param params
	 * @return
	 */
	public int delete(BoardDto bDto);

	/**
	 * 게시글 삭제할 때 파일 통째로 삭제
	 * 
	 * @param bDto
	 * @return
	 */
	public int deleteFile(BoardDto bDto);

	/*
	 * 게시글 수정시 파일 개별 삭제
	 */
	public int deleteAttFile(FileDto fDto);

	/**
	 * 게시글 내 파일 개수 구하기
	 * 
	 * @param fDto
	 * @return
	 */
	public int getFileCount(FileDto fDto);

	public ArrayList<BoardDto> search(HashMap<String, String> serach);
}