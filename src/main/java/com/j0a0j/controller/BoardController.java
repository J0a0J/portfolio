package com.j0a0j.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.FileDto;
import com.j0a0j.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

	private final BoardService bService;
	private String typeSeq = "2";

	@RequestMapping("/list.do")
	public ModelAndView list(@RequestParam(required = false, defaultValue = "1") int page) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/list");
		mv.addObject("page", page);

		return mv;
	}

	@RequestMapping("/test.do")
	public ModelAndView test() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		return mv;
	}

	// 글쓰기 페이지로
	@RequestMapping("/goToWrite.do")
	public ModelAndView goToWrite(@RequestParam HashMap<String, Object> params) {
		if (!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/write");
		return mv;
	}

	// 수정 페이지로
	@RequestMapping("/goToUpdate.do")
	public ModelAndView goToUpdate(BoardDto bDto, HttpSession session) {

		ModelAndView mv = new ModelAndView();

		// read로 하면 조회수가 총 +2 되기 때문에 uri 로 값 받기
		System.out.println("BOARD DTO IS THIS!!!!!      " + bDto);
		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		// 게시글 정보
		mv.addObject("boardMember", bDto);
		// 첨부 파일 정보
		ArrayList<FileDto> attFiles = bService.readFile(bDto);
		mv.addObject("attFiles", attFiles);
		mv.addObject("currentPage", bDto.getPage());

		mv.setViewName("/board/update");

		return mv;

	}

}