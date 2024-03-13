package com.lhs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriUtils;

import com.lhs.dto.BoardDto;
import com.lhs.dto.FileDto;
import com.lhs.service.AttFileService;
import com.lhs.service.BoardService;
import com.lhs.util.FileUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {

	@Autowired BoardService bService;
//	@Autowired AttFileService attFileService;
	@Autowired FileUtil fileUtil;

	private String typeSeq = "2";

	@RequestMapping("/board/list.do")
	public ModelAndView goLogin(@RequestParam HashMap<String, String> params){
		// 전체 페이지 수 
		int articleTotalCnt = bService.getTotalArticleCnt(params);
		System.out.println("Board PARAMAS " + params);
		System.out.println("ARTIRCLE count " + articleTotalCnt);
		
		// 전체 페이지 수 - 전체 페이지를 10으로 나눈 후 나머지 값을 위해 페이지 1개 더 만들어야 함. 
		int pageTotalNum = (int) Math.ceil((double) articleTotalCnt / 10);
		// 현재 페이지
		int currentPage = Integer.parseInt(params.get("page"));
		// 몫 
		int quot = currentPage / 10;
		// 나머지 
		int remainder = currentPage % 10;
		// 10번 대, 20번 대 페이지로 넘어갈 때 필요한 변수
		int lastPageTimes = pageTotalNum / 10;
		int pageTimes = 0;
		if(quot > 0) {
			if(remainder == 0) {
				pageTimes = quot - 1;
			} else {
				pageTimes = quot;
			}
		}
		
		ModelAndView mv = new ModelAndView();
		
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		
		ArrayList<BoardDto> memberList = bService.list(params);
		for(BoardDto member : memberList) {
			System.out.println(member);
		}

		mv.addObject("pageTimes", pageTimes);
		mv.addObject("lastPageTimes", lastPageTimes);
		mv.addObject("currentPage", params.get("page"));
		mv.addObject("pageTotalNum", pageTotalNum);
		mv.addObject("memberList",memberList);
		mv.setViewName("board/list");
		return mv;
	}

	@RequestMapping("/test.do")
	public ModelAndView test() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		return mv;
	}

	//글쓰기 페이지로 	
	@RequestMapping("/board/goToWrite.do")
	public ModelAndView goToWrite(@RequestParam HashMap<String, Object> params) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/write");
		return mv;
	}

//			@RequestParam HashMap<String, Object> params,
	@RequestMapping("/board/write.do")
	@ResponseBody
	public HashMap<String, Object> write(
			@ModelAttribute("BoardDto") BoardDto bDto, MultipartHttpServletRequest mReq) {
		int boardType = bDto.getTypeSeq();
		if(boardType == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		} 

		// parameter, 관련 정보도 다 같이 옴. like title, content
		int result = bService.write(bDto, mReq.getFiles("attFiles"));
		
		BoardDto view = bService.readAfterWriting(bDto);
		
		String link = "/board/read.do?boardSeq=" + view.getBoardSeq() +  
				"&hasFile=" + view.getHasFile() + 
				"&currentPage=1";
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cnt", result);
		map.put("msg", result==1?"게시물 작성 완료!!!":"게시물 작성 실패!!!");
		map.put("nextPage", result==1?"/board/list.do" : "/board/list.do");
		return map;
	}
	
	@RequestMapping("/board/download.do")
	@ResponseBody
	public byte[] downloadFile(@RequestParam int fileIdx,  HttpServletResponse rep) {
		//1.받아온 파람의 파일 pk로 파일 전체 정보 불러온다. -attFilesService필요! 
		// 파일 전체 정보 받아오기 
		FileDto fileInfo = bService.getFileInfo(fileIdx);
		System.out.println("FILE INFO IN DOWNLOAD FILE          " + fileInfo);
		
		//2. 받아온 정보를 토대로 물리적으로 저장된 실제 파일을 읽어온다.
		byte[] fileByte = null;
		
		if(fileInfo != null) { //지워진 경우 
			//파일 읽기 메서드 호출 
			fileByte = fileUtil.readFile(fileInfo);
		}
		// 파일명이 한글이면 오류가 발생하기에 꼭 utf-8로 해줘야 한다.
		String fileName = UriUtils.encode(fileInfo.getFileName(), "utf-8");
		
		//돌려보내기 위해 응답(httpServletResponse rep)에 정보 입력. **** 응답사용시 @ResponseBody 필요 ! !
		//Response 정보전달: 파일 다운로드 할수있는 정보들을 브라우저에 알려주는 역할 
		rep.setHeader("Content-Disposition", "attachment; filename=\""+ fileName + "\""); //파일명
		rep.setContentType(fileInfo.getFileType()); // content-type
		rep.setContentLength(fileInfo.getFileSize()); // 파일사이즈 
		rep.setHeader("pragma", "no-cache");
		rep.setHeader("Cache-Control", "no-cache");
		
		return fileByte;
	}

	@RequestMapping("/board/read.do")
	public ModelAndView read(@ModelAttribute("BoardDto") BoardDto bDto) {
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		
		System.out.println("BOARD DTO IN READ !!! " + bDto);

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
		// 게시글에서 목록 누르면 같은 페이지의 목록으로 이동하기 위해 추가 
		mv.addObject("currentPage", bDto.getPage());
		mv.addObject("boardList", boardList);
		mv.addObject("boardSeq", bDto.getBoardSeq());
		mv.setViewName("/board/read");
		return mv;
	}	


	//수정  페이지로 	
	@RequestMapping("/board/goToUpdate.do")
	public ModelAndView goToUpdate(BoardDto bDto, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// read로 하면 조회수가 총 +2 되기 때문에 uri 로 값 받기 
		System.out.println("BOARD DTO IS THIS!!!!!      " + bDto);
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		// 게시글 정보 
		mv.addObject("boardMember", bDto);
		// 첨부 파일 정보 
		ArrayList<FileDto> attFiles = bService.readFile(bDto);
		mv.addObject("attFiles", attFiles);
		mv.addObject("curentPage", bDto.getPage());
		
		mv.setViewName("/board/update");

		return mv;

	}

	@RequestMapping("/board/update.do")
	@ResponseBody // !!!!!!!!!!!! 비동기 응답 
	public HashMap<String, Object> update(@ModelAttribute("BoardDto") BoardDto bDto,
			MultipartHttpServletRequest mReq) {
		
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
			
		}
		
		System.out.println("BDTO FDSDSFDS! " + bDto);
		
		int result = bService.update(bDto, mReq.getFiles("attFiles"));

		HashMap<String, Object> map = new HashMap<String , Object>();
		
		map.put("cnt", result);
		map.put("msg", result==1?"게시물 업데이트 완료!!!":"게시물 업데이트 실패!!!");
//		map.put("nextPage", result==1?"/board/list.do?page=" + bDto.getPage() : "/board/list.do?page=" + bDto.getPage() );
		
		return map;
	}

	@RequestMapping("/board/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {
		System.out.println("BOARD DTO !!!!!" + bDto);
		System.out.println("DELETE   						" + bDto);
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		int result = bService.delete(bDto);
		System.out.println("RESULT IS HERE " + result);
		
		// /board/list.do?page=1
		String link = "/board/list.do?page=" + bDto.getPage(); 
		HashMap<String, Object> map = new HashMap<>();
		System.out.println("THIS IS LINK!!!!! "+ link);
//		map.put("nextPage", result==1?"/board/list.do?page=" + bDto.getPage() : "/board/list.do?page=" + bDto.getPage() );
		return map;
	}

	@RequestMapping("/board/deleteAttFile.do")
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