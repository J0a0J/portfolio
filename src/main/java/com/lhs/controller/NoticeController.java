package com.lhs.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.lhs.service.AttFileService;
import com.lhs.service.BoardService;
import com.lhs.util.FileUtil;

@Controller
public class NoticeController {

	@Autowired BoardService bService;
	@Autowired AttFileService attFileService;
	@Autowired FileUtil fileUtil;

	private String typeSeq = "1";

	@RequestMapping("/notice/list.do")
	public ModelAndView goLogin(@RequestParam HashMap<String, String> params){
		ModelAndView mv = new ModelAndView();
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
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
	public HashMap<String, Object> write(@RequestParam HashMap<String, Object> params,
			MultipartHttpServletRequest mReq) {		
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = 0;
		String msg = (result == 1) ? "성공" : "실패";

		map.put("result", result);
		map.put("msg", msg);
		map.put("boardSeq", params.get("boardSeq"));
		return map;
	}

	@RequestMapping("/notice/read.do")
	public ModelAndView read(@RequestParam HashMap<String, Object> params) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		ModelAndView mv = new ModelAndView();		
		// 글 상세조회 select 
		HashMap<String, Object> boardInfo = null;
		mv.addObject("currentPage", params.get("currentPage"));
		mv.addObject("boardInfo", boardInfo);

		mv.setViewName("/notice/read");


		return mv;
	}	

	//수정  페이지로 	
	@RequestMapping("/notice/goToUpdate.do")
	public ModelAndView goToUpdate(@RequestParam HashMap<String, Object> params, HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		if(session.getAttribute("memberId") != null) {// 로그인 상태 
			//본인 체크. 

			//해당 글 정보 받기 위해 read 
			HashMap<String, Object> boardInfo = bService.read(params);
			mv.addObject("boardInfo" , boardInfo);
			System.out.println("fuuuuuuuuuck");
			System.out.println(boardInfo);
			if(boardInfo.get("has_file").equals("Y")) {//첨부파일 존재하면 
				List<HashMap<String, Object>> fileInfos = attFileService.readAttFiles(params); 
				mv.addObject("attFiles", fileInfos);

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
	public HashMap<String, Object> update(@RequestParam HashMap<String,Object> params, MultipartHttpServletRequest mReq) {

		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}

		System.out.println("updateParamssssssss:" + params);


		//1. 첨부파일 유무 확인 : MultipartFile  
		List<MultipartFile> mFiles = mReq.getFiles("attFiles");

		//1-1) 원래 첨부파일 없던 글에 첨부파일을 추가하는 경우 has_file 0 -> 1 변경해주어야함.. 
		if(params.get("hasFile").equals("N")) { // 첨부파일 없는 글이면 

			//새로 추가된 파일이 존재하는지 이름 뒤져서 검사한다.
			for(MultipartFile mFile : mFiles) {
				if(!mFile.getOriginalFilename().equals("")) { //파일 이름 존재하면 파일 추가해준 것이므로 

					params.put("hasFile", "Y");// hasFile값을 1로 바꿔서 put 해준다. 
					break;
				}
			}
		}
		//1-2) 기존에 첨부파일 있던 글에 첨부파일 수정 된 경우. has file 1 건들필요 없고, 첨부파일 삭제시 hasFile = 0이 되므로 건들필요없음..   


		//비동기식은 HashMap에 정보담아 return 한다 !! 
		HashMap<String, Object> map = new HashMap<String, Object>();
		//2. 글 정보 수정 service 호출.
		int result = bService.update(params,mFiles); 
		//쿼리성공: 1 / 실패 : 0 
		String msg = (result == 1) ? "성공" : "실패";

		//비동기 리턴할맵에 필요정도(쿼리 결과, 메세지, 글번호) PUT !!  
		//like addObject of ModelandView 기능 .. 
		map.put("result", result);
		map.put("msg", msg);
		map.put("boardSeq", params.get("boardSeq"));

		return map;
	}

	@RequestMapping("/notice/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@RequestParam HashMap<String, Object> params, HttpSession session) {

		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		//비동기 리턴해줄 맵 생성
		HashMap<String, Object> map = new HashMap<String, Object>();

		if(session.getAttribute("memberId") != null) { // 세션에 값있을 : 로긴상태일때만 
			//1. 글 정보 검사 - has_file 추출.  
			HashMap<String, Object> boardInfo = bService.read(params);
			params.put("hasFile", boardInfo.get("has_file"));
			//삭제 쿼리 호출 
			int result = 0;

			//쿼리결과따라 msg 값 대입 
			String msg = (result == 1 ? "성공" : "실패");

			//필요정보 map에 put 
			map.put("msg", msg);
			map.put("result", result);
			map.put("typeSeq", params.get("typeSeq"));

		}else {
			// 로그인 세션 풀렸을때
		}
		return map; // 비동기: map return 
	}

}
