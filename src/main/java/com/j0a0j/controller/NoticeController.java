package com.j0a0j.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.CommentDto;
import com.j0a0j.dto.FileDto;
import com.j0a0j.service.BoardService;
import com.j0a0j.util.FileUtil;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	BoardService bService;
	@Autowired
	FileUtil fileUtil;

	private String typeSeq = "1";

	@RequestMapping("/list.do")
	public ModelAndView list(@RequestParam(required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/notice/list");
		mv.addObject("page", page);

		return mv;
	}

	// 글쓰기 페이지로
	@RequestMapping("/goToWrite.do")
	public ModelAndView goToWrite(@RequestParam HashMap<String, Object> params) {
		if (!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/notice/write");
		return mv;
	}

	@GetMapping("/read.do")
	public ModelAndView read(@RequestParam("boardSeq") int boardSeq, @ModelAttribute("BoardDto") BoardDto bDto) {

		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		bDto.setBoardSeq(boardSeq);
		System.out.println("BOARD DTO IN READ !!! " + bDto);

		ModelAndView mv = new ModelAndView();
		// 게시글 정보
		BoardDto boardList = bService.read(bDto);

		// 파일이 있는지 확인
		String checkFile = boardList.getHasFile();
		System.out.println("CHECK FILE   " + checkFile);
		if (checkFile != null) {
			// 파일 정보
			ArrayList<FileDto> fDto = bService.readFile(bDto);
			mv.addObject("attFiles", fDto);
		}
		// 댓글 불러오기
		ArrayList<CommentDto> comments = bService.readComment(boardSeq);
		// 게시글에서 목록 누르면 같은 페이지의 목록으로 이동하기 위해 추가
		mv.addObject("currentPage", bDto.getPage());
		mv.addObject("boardList", boardList);
		mv.addObject("boardSeq", bDto.getBoardSeq());
		mv.addObject("comments", comments);
		mv.setViewName("notice/read");
		return mv;
	}

	// 수정 페이지로
	@RequestMapping("/goToUpdate.do")
	public ModelAndView goToUpdate(BoardDto bDto, HttpSession session) {

		ModelAndView mv = new ModelAndView();
		System.out.println("BOARD DTO IS THIS!!!!!      " + bDto);
		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		if (session.getAttribute("memberId") != null) {// 로그인 상태
			// 본인 체크.
		}

		mv.addObject("boardMember", bDto);

		ArrayList<FileDto> attFiles = bService.readFile(bDto);
		mv.addObject("attFiles", attFiles);
		mv.addObject("currentPage", bDto.getPage());

		mv.setViewName("/notice/update");

		return mv;

	}
}
