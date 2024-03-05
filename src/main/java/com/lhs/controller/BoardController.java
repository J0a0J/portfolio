package com.lhs.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
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
import com.lhs.service.AttFileService;
import com.lhs.service.BoardService;
import com.lhs.util.FileUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {

	@Autowired BoardService bService;
	@Autowired AttFileService attFileService;
	@Autowired FileUtil fileUtil;

	private String typeSeq = "2";

	@RequestMapping("/board/list.do")
	public ModelAndView goLogin(@RequestParam HashMap<String, String> params){
		ModelAndView mv = new ModelAndView();
		ArrayList<BoardDto> memberList = bService.list(params);
		for(BoardDto member : memberList) {
			System.out.println(member);
		}
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
		System.out.println("BDTO is THIS !!!!!!!!!????????      " + bDto);
//		// parameter, 관련 정보도 다 같이 옴. like title, content
		int result = bService.write(bDto, mReq.getFiles("attFiles"));
		System.out.println("RESULT        "+result);

		return null;
	}
	
	@RequestMapping("/board/download.do")
	@ResponseBody
	public byte[] downloadFile(@RequestParam int fileIdx, HttpServletResponse rep) {
		//1.받아온 파람의 파일 pk로 파일 전체 정보 불러온다. -attFilesService필요! 
		HashMap<String, Object> fileInfo = null;
		
		//2. 받아온 정보를 토대로 물리적으로 저장된 실제 파일을 읽어온다.
		byte[] fileByte = null;
		
//		if(fileInfo != null) { //지워진 경우 
//			//파일 읽기 메서드 호출 
//			fileByte = fileUtil.readFile(fileInfo);
//		}
		
		//돌려보내기 위해 응답(httpServletResponse rep)에 정보 입력. **** 응답사용시 @ResponseBody 필요 ! !
		//Response 정보전달: 파일 다운로드 할수있는 정보들을 브라우저에 알려주는 역할 
		rep.setHeader("Content-Disposition", "attachment; filename=\""+fileInfo.get("file_name") + "\""); //파일명
		rep.setContentType(String.valueOf(fileInfo.get("file_type"))); // content-type
		rep.setContentLength(Integer.parseInt(String.valueOf(fileInfo.get("file_size")))); // 파일사이즈 
		rep.setHeader("pragma", "no-cache");
		rep.setHeader("Cache-Control", "no-cache");
		
		return fileByte;
	}

	@RequestMapping("/board/read.do")
	public ModelAndView read(@ModelAttribute("BoardDto") BoardDto bDto) {
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		ModelAndView mv = new ModelAndView();
		BoardDto memberList = bService.read(bDto);
		System.out.println("memberLISt                        " + memberList);
		mv.addObject("memberList", memberList);
		mv.addObject("boardSeq", bDto.getBoardSeq());
		mv.setViewName("/board/read");
		return mv;
	}	


	//수정  페이지로 	
	@RequestMapping("/board/goToUpdate.do")
	public ModelAndView goToUpdate(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		} 
		BoardDto boardMember = bService.read(bDto);
		System.out.println("GO TO UPDATE 's board info : " + boardMember.getBoardSeq());
		mv.addObject("boardMember", boardMember);
		mv.setViewName("/board/update");
		
		System.out.println("GO TO UPDATE 's params info : " + boardMember);
		return mv;

	}

	@RequestMapping("/board/update.do")
	@ResponseBody // !!!!!!!!!!!! 비동기 응답 
	public HashMap<String, Object> update(@ModelAttribute("BoardDto") BoardDto bDto,
			MultipartHttpServletRequest mReq) {
//		BoardDto          !!!!!!!! {memberNick=saaaaa, is_ajax=true, hasFile=, memberIdx=, 
//		typeSeq=, action=contact_send, boardSeq=, title=연습, content=연습장
//		, memberId=}
		System.out.println("BoardDto          !!!!!!!! " + bDto);
		
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		
		int result = bService.update(bDto, null);
		
		System.out.println("FIRST UPDATE BDTO's INFO IS     must be 1     " + result);
		HashMap<String, Object> map = new HashMap<String , Object>();
		map.put("cnt", result);
		map.put("msg", result==1?"게시물 업데이트 완료!!!":"게시물 업데이트 실패!!!");
		map.put("nextPage", result==1?"/board/list.do" : "/board/list.do");
		return map;
	}

	@RequestMapping("/board/delete.do")
	@ResponseBody
	public ModelAndView delete(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {
		System.out.println("DELETE   						" + bDto);
		if(bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		int result = bService.delete(bDto);
		System.out.println("MEMBER INFO          " + result);
//		int result = bService.delete(memberInfo);
//		System.out.println("DELETE RESULT      " + result);
//		return null; // 비동기: map 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/list");
		return mv;
	}

	@RequestMapping("/board/deleteAttFile.do")
	@ResponseBody
	public HashMap<String, Object> deleteAttFile(@RequestParam HashMap<String, Object> params) {

		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		return null;
	} 



}