package com.j0a0j.rest.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriUtils;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.CommentDto;
import com.j0a0j.dto.FileDto;
import com.j0a0j.response.dto.BoardResponseDto;
import com.j0a0j.service.BoardService;
import com.j0a0j.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
@MultipartConfig
@RequestMapping("/board")
public class BoardRestController {

	private final BoardService bService;

	private final FileUtil fileUtil;

	private String typeSeq = "2";

	@GetMapping("/{page}.do")
	@ResponseBody
	public BoardResponseDto getList(@PathVariable int page, @RequestParam HashMap<String, String> params) {
		// 공지글인지 게시글인지 구분해줘야 함.
		if (!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}

		params.put("page", String.valueOf(page));
		// 전체 페이지 수
		int articleTotalCnt = bService.getTotalArticleCnt(params);

		// 전체 페이지 수 - 전체 페이지를 10으로 나눈 후 나머지 값을 위해 페이지 1개 더 만들어야 함.
		int pageTotalNums = (int) Math.ceil((double) articleTotalCnt / 10);
		// 현재 페이지
		int currentPage = Integer.parseInt(params.get("page"));
		// 몫
		int quot = currentPage / 10;
		// 나머지
		int remainder = currentPage % 10;
		int pageGroup = 0;
		if (quot > 0) {
			if (remainder == 0) {
				pageGroup = quot - 1;
			} else {
				pageGroup = quot;
			}
		}

		ArrayList<BoardDto> boardInfo = bService.list(params);
		BoardResponseDto bInfo = new BoardResponseDto();
		bInfo.setBoardInfo(boardInfo);
		bInfo.setPageGroup(pageGroup);
		bInfo.setPageTotalNums(pageTotalNums);

		System.out.println(bInfo);

		return bInfo;
	}

	@GetMapping("/read.do")
	public ModelAndView readWriting(@RequestParam("boardSeq") int boardSeq, @ModelAttribute("BoardDto") BoardDto bDto) {
		// 공지글인지 게시글인지 구분
		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		bDto.setBoardSeq(boardSeq);

		ModelAndView mv = new ModelAndView();
		// 게시글 정보
		BoardDto boardList = bService.read(bDto);

		// 파일이 있는지 확인
		String checkFile = boardList.getHasFile();
		if (checkFile != null) {
			// 파일 정보
			ArrayList<FileDto> fDto = bService.readFile(bDto);
			mv.addObject("attFiles", fDto);
		}

		ArrayList<CommentDto> comments = bService.readComment(boardSeq);

		// 게시글에서 목록 누르면 같은 페이지의 목록으로 이동하기 위해 추가
		mv.addObject("currentPage", bDto.getPage());
		// 게시글 정보
		mv.addObject("boardList", boardList);
		mv.addObject("boardSeq", bDto.getBoardSeq());
		// 댓글 정보
		mv.addObject("comments", comments);
		mv.setViewName("board/read");
		return mv;
	}

	// 댓글 작성 시
	@PostMapping("/comment.do")
	public int writeCommnet(@RequestBody CommentDto cDto) {
		if (cDto.getTypeSeq() == 0) {
			cDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		int result = bService.writeComment(cDto);

		return result;
	}

	@PostMapping("write.do")
	@ResponseBody
	public HashMap<String, Object> write(@ModelAttribute("BoardDto") BoardDto bDto) {
		int boardType = bDto.getTypeSeq();
		if (boardType == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		// parameter, 관련 정보도 다 같이 옴. like title, content
		int result = bService.write(bDto, null);

		BoardDto view = bService.readAfterWriting(bDto);

		String link = "/board/read.do?boardSeq=" + view.getBoardSeq() + "&hasFile=" + view.getHasFile()
				+ "&currentPage=1";

		HashMap<String, Object> map = new HashMap<>();
		map.put("cnt", result);
		map.put("msg", result == 1 ? "게시물 작성 완료!!!" : "게시물 작성 실패!!!");

		return map;
	}

	@GetMapping("/download.do")
	@ResponseBody
	public byte[] downloadFile(@RequestParam int fileIdx, HttpServletResponse rep) {
		System.out.println();

		// 1.받아온 파람의 파일 pk로 파일 전체 정보 불러온다. -attFilesService필요!
		// 파일 전체 정보 받아오기
		FileDto fileInfo = bService.getFileInfo(fileIdx);
		System.out.println("FILE INFO IN DOWNLOAD FILE          " + fileInfo);

		// 2. 받아온 정보를 토대로 물리적으로 저장된 실제 파일을 읽어온다.
		byte[] fileByte = null;

		if (fileInfo != null) { // 지워진 경우
			// 파일 읽기 메서드 호출
			fileByte = fileUtil.readFile(fileInfo);
		}
		// 파일명이 한글이면 오류가 발생하기에 꼭 utf-8로 해줘야 한다.
		String fileName = UriUtils.encode(fileInfo.getFileName(), "utf-8");

		// 돌려보내기 위해 응답(httpServletResponse rep)에 정보 입력. **** 응답사용시 @ResponseBody 필요 ! !
		// Response 정보전달: 파일 다운로드 할수있는 정보들을 브라우저에 알려주는 역할
		rep.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\""); // 파일명
		rep.setContentType(fileInfo.getFileType()); // content-type
		rep.setContentLength(fileInfo.getFileSize()); // 파일사이즈
		rep.setHeader("pragma", "no-cache");
		rep.setHeader("Cache-Control", "no-cache");

		return fileByte;
	}

	@PutMapping("update.do")
	public HashMap<String, Object> update(@ModelAttribute("BoardDto") BoardDto bDto) {

//		List<MultipartFile> fileList = new ArrayList<>();
//		if (mReq != null) {
//			if (mReq.getFiles("file").get(0).getSize() != 0) {
//				fileList = mReq.getFiles("file");
//			}
//		}

		System.out.println("UPDATE REST CONTROLLER   " + bDto.getBoardSeq());

		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));

		}

		int result = bService.update(bDto);

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("cnt", result);
		map.put("msg", result == 1 ? "게시물 수정했습니다." : "게시물 수정 실패했습니다.");

		return map;
	}

	@PostMapping("/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {
		System.out.println("BOARD DTO !!!!!" + bDto);
		System.out.println("DELETE   						" + bDto);
		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		// 글 삭제 전 댓글부터 삭제
		int result = bService.deleteComment(bDto.getBoardSeq());
		if (result > 0) {
			System.out.println("Comment delete successfully");
		}

		// 게시글 삭제
		result = bService.delete(bDto);
		System.out.println("RESULT IS HERE " + result);

		HashMap<String, Object> map = new HashMap<>();
		map.put("msg", result == 1 ? "게시물 삭제했습니다." : "게시물 삭제 실패했습니다.");

		return map;
	}

	@PostMapping("/deleteAttFile.do")
	@ResponseBody
	public HashMap<String, Object> deleteAttFile(@ModelAttribute("FileDto") FileDto fDto) {
		System.out.println("params is here " + fDto);
//		if(!params.containsKey("typeSeq")) {
//			params.put("typeSeq", this.typeSeq);
//		}
//		
		bService.deleteAttFile(fDto);
		return null;
	}

}