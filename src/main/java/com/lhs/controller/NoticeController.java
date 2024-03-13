package com.lhs.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.lhs.dto.BoardDto;
import com.lhs.dto.FileDto;
//import com.lhs.service.AttFileService;
import com.lhs.service.BoardService;
import com.lhs.util.FileUtil;

@Controller
public class NoticeController {

	@Autowired BoardService bService;
//	@Autowired AttFileService attFileService;
	@Autowired FileUtil fileUtil;

	private String typeSeq = "1";

	@RequestMapping("/notice/list.do")
	public ModelAndView goLogin(@RequestParam HashMap<String, String> params,
			@RequestParam(value="searchSelect" , required=false) String searchSelect){
		// 전체 페이지 수 
		int articleTotalCnt = bService.getTotalArticleCnt(params);
		
		System.out.println("SEARCH SELECT !!!!!!!!! " + searchSelect);
		params.put("typeSeq", this.typeSeq);
		
		
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
		ArrayList<BoardDto> memberList = bService.list(params);
		System.out.println("ARTIRCLE count " + memberList);
		for(BoardDto member : memberList) {
			System.out.println(member);
		}

		mv.addObject("pageTimes", pageTimes);
		mv.addObject("lastPageTimes", lastPageTimes);
		mv.addObject("currentPage", params.get("page"));
		mv.addObject("pageTotalNum", pageTotalNum);
		mv.addObject("memberList",memberList);
		mv.setViewName("notice/list");
		return mv;
	}


	//글쓰기 페이지로 	
	@RequestMapping("/notice/goToWrite.do")
	public ModelAndView goToWrite(@RequestParam HashMap<String, Object> params) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/notice/write");
		return mv;
	}

	@RequestMapping("/notice/write.do")
	@ResponseBody
	public HashMap<String, Object> write(@ModelAttribute("BoardDto") BoardDto bDto,
			MultipartHttpServletRequest mReq) {		
		int boardType = bDto.getTypeSeq();
		if(boardType == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		} 
		
		int result = bService.write(bDto, mReq.getFiles("attFiles"));

		HashMap<String, Object> map = new HashMap<String, Object>();
		String msg = (result == 1) ? "성공" : "실패";

		map.put("result", result);
		map.put("msg", msg);
		
		return map;
	}

	@RequestMapping("/notice/read.do")
	public ModelAndView read(@ModelAttribute("BoardDto") BoardDto bDto) {
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		
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
	@RequestMapping("/notice/goToUpdate.do")
	public ModelAndView goToUpdate(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {

		ModelAndView mv = new ModelAndView();
		
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		if(session.getAttribute("memberId") != null) {// 로그인 상태 
			//본인 체크. 

			//해당 글 정보 받기 위해 read 
			BoardDto boardInfo = bService.read(bDto);
			mv.addObject("boardInfo" , boardInfo);
			
			System.out.println(boardInfo);
			String checkFile = boardInfo.getHasFile();
			if (checkFile != null) {
				// 파일 정보 
				ArrayList<FileDto> fDto = bService.readFile(bDto);
				mv.addObject("attFiles", fDto);
			}
			mv.setViewName("/notice/update");
			return mv;
		}else { // 로그인 세션 풀렸을때,  -> 잘못된 접근.. -> 공통화 
			mv.setViewName("common/error"); // 잘못된 접근시 error 페이지 보여준다. 

			mv.addObject("msg" , "로그인 하세요");
			mv.addObject("nextLocation","/index.do");

		}
		return mv;

	}

	@RequestMapping("/notice/update.do")
	@ResponseBody // !!!!!!!!!!!! 비동기 응답 
	public HashMap<String, Object> update(@ModelAttribute("BoardDto") BoardDto bDto, MultipartHttpServletRequest mReq) {

		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
			
		}
		
		System.out.println("BDTO FDSDSFDS! " + bDto);
		
		int result = bService.update(bDto, mReq.getFiles("attFiles"));

		HashMap<String, Object> map = new HashMap<String , Object>();
		
		map.put("cnt", result);
		map.put("msg", result==1?"게시물 업데이트 완료!!!":"게시물 업데이트 실패!!!");

		//1. 첨부파일 유무 확인 : MultipartFile  
//		List<MultipartFile> mFiles = mReq.getFiles("attFiles");
//
//		//1-1) 원래 첨부파일 없던 글에 첨부파일을 추가하는 경우 has_file 0 -> 1 변경해주어야함.. 
//		String checkFile = bDto.getHasFile();
//		if (checkFile != null) {
//			// 파일 정보 
//			ArrayList<FileDto> fDto = bService.readFile(bDto);
//			map.addObject("attFiles", fDto);
//		}
//		//1-2) 기존에 첨부파일 있던 글에 첨부파일 수정 된 경우. has file 1 건들필요 없고, 첨부파일 삭제시 hasFile = 0이 되므로 건들필요없음..   
//
//
//		//비동기식은 HashMap에 정보담아 return 한다 !! 
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		//2. 글 정보 수정 service 호출.
//		int result = bService.update(bDto,mFiles); 
//		//쿼리성공: 1 / 실패 : 0 
//		String msg = (result == 1) ? "성공" : "실패";
//
//		//비동기 리턴할맵에 필요정도(쿼리 결과, 메세지, 글번호) PUT !!  
//		//like addObject of ModelandView 기능 .. 
//		map.put("result", result);
//		map.put("msg", msg);
//		map.put("boardSeq", params.get("boardSeq"));

		return map;
	}

	@RequestMapping("/notice/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {
	

		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		//비동기 리턴해줄 맵 생성
//		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int result = bService.delete(bDto);
		System.out.println("RESULT IS HERE " + result);
		
		// /board/list.do?page=1
		String link = "/board/list.do?page=" + bDto.getPage(); 
		HashMap<String, Object> map = new HashMap<>();
		System.out.println("THIS IS LINK!!!!! "+ link);
		map.put("nextPage", result==1?"/board/list.do?page=" + bDto.getPage() : "/board/list.do?page=" + bDto.getPage() );
		return map;

//		if(session.getAttribute("memberId") != null) { // 세션에 값있을 : 로긴상태일때만 
//			//1. 글 정보 검사 - has_file 추출.  
//			HashMap<String, Object> boardInfo = bService.read(params);
//			params.put("hasFile", boardInfo.get("has_file"));
//			//삭제 쿼리 호출 
//			int result = 0;
//
//			//쿼리결과따라 msg 값 대입 
//			String msg = (result == 1 ? "성공" : "실패");
//
//			//필요정보 map에 put 
//			map.put("msg", msg);
//			map.put("result", result);
//			map.put("typeSeq", params.get("typeSeq"));
//
//		}else {
//			// 로그인 세션 풀렸을때
//		}
//		return map; // 비동기: map return 
	}

}
