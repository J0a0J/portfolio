package com.j0a0j.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.CommentDto;
import com.j0a0j.dto.FileDto;

public interface BoardService {

	public ArrayList<BoardDto> list(HashMap<String, String> params);

	public int getTotalArticleCnt(HashMap<String, String> params);

	public int writeFile(BoardDto bDto, List<MultipartFile> mFiles);

//	public int write(HashMap<String, Object> params, List<MultipartFile> mFiles);
	public int write(BoardDto bDto, List<MultipartFile> mFiles);

	/**
	 * 글 조회
	 */
	public BoardDto read(BoardDto bDto);

	/**
	 * 글 작성 후 작성 글 보여주기
	 * 
	 * @param bDto
	 * @return
	 */
	public BoardDto readAfterWriting(BoardDto bDto);

	/**
	 * 간략적인 파일 정보 조회
	 * 
	 * @param bDto
	 * @return
	 */
	public ArrayList<FileDto> readFile(BoardDto bDto);

	/**
	 * 파일 다운로드 받기 위해 보다 자세한 파일 정보 조회
	 * 
	 * @param fileIdx
	 * @param boardSeq
	 * @return
	 */
	public FileDto getFileInfo(int fileIdx);

	/**
	 * 댓글 작
	 * 
	 * @param commentInfo
	 * @return
	 */
	public int writeComment(CommentDto cDto);

	/**
	 * 게시글 읽을 때 댓글도 같이 읽기
	 * 
	 * @param boardSeq
	 * @return
	 */
	public ArrayList<CommentDto> readComment(int boardSeq);

	/**
	 * 글 수정 update
	 * 
	 * @param params
	 * @return
	 */
	// 파일 업로드 안 돼서 글만 수정하게 수정.
//	public int update(BoardDto bDto, List<MultipartFile> mFiles);
	public int update(BoardDto bDto);

	/**
	 * 첨부파일 삭제(수정 페이지에서 삭제버튼 눌러 삭제하는 경우임)
	 * 
	 * @param params
	 * @return
	 */
	public int deleteAttFile(FileDto fDto);

	/**
	 * 글 삭제 delete
	 * 
	 * @param params
	 * @return
	 */
	public int delete(BoardDto bDto);

	/**
	 * 글 검색
	 * 
	 * @param searchSelect
	 * @param searchContent
	 * @return
	 */
	public ArrayList<BoardDto> search(HashMap<String, String> search);

}
