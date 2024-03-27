package com.j0a0j.rest.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.UriUtils;

import com.j0a0j.dto.BoardDto;
import com.j0a0j.dto.FileDto;
import com.j0a0j.response.dto.BoardResponseDto;
import com.j0a0j.service.BoardService;
import com.j0a0j.util.FileUtil;

@RestController
@RequestMapping("/notice")
public class NoticeRestController {

	@Autowired
	BoardService bService;
//	@Autowired AttFileService attFileService;
	@Autowired
	FileUtil fileUtil;

	private String typeSeq = "1";

	@GetMapping("/{page}.do")
	public BoardResponseDto goLogin(@PathVariable int page, @RequestParam HashMap<String, String> params,
			@RequestParam(value = "searchSelect", required = false) String searchSelect,
			@RequestParam(value = "searchContent", required = false) String searchContent) {

		// 전체 페이지 수
		int articleTotalCnt;
		ArrayList<BoardDto> memberList;
		// 공지사항, 자유게시판 결과를 분리하기 위해
		params.put("typeSeq", this.typeSeq);
		params.put("page", String.valueOf(page));

		System.out.println("searchSelect in list   " + searchSelect);
		// 검색을 한다면 Current page 는 1로 설정해야 함.
		if (searchSelect != null) {
			params.put("select", searchSelect);
			params.put("content", searchContent);
			memberList = bService.search(params);
			System.out.println("params !!!! inn list   " + params);
			articleTotalCnt = memberList.size();
		} else {
			articleTotalCnt = bService.getTotalArticleCnt(params);
			memberList = bService.list(params);
		}

		System.out.println("ARticle total count  " + articleTotalCnt);
		// 전체 페이지 수 - 전체 페이지를 10으로 나눈 후 나머지 값을 위해 페이지 1개 더 만들어야 함.
		int pageTotalNums = (int) Math.ceil((double) articleTotalCnt / 10);
		System.out.println("pageTotalNums  " + pageTotalNums);
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

	@RequestMapping("/downloadFile.do")
	@ResponseBody
	public byte[] downloadFile(@RequestParam int fileIdx, HttpServletResponse rep) {
		// 1.받아온 파람의 파일 pk로 파일 전체 정보 불러온다. -attFilesService필요!
		// 파일 전체 정보 받아오기
		FileDto fileInfo = bService.getFileInfo(fileIdx);

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

	@RequestMapping("/write.do")
	@ResponseBody
	public HashMap<String, Object> write(@ModelAttribute("BoardDto") BoardDto bDto, MultipartHttpServletRequest mReq) {
		int boardType = bDto.getTypeSeq();
		if (boardType == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}

		int result = bService.write(bDto, mReq.getFiles("attFiles"));

		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDto view = bService.readAfterWriting(bDto);

		String link = "/notice/read.do?boardSeq=" + view.getBoardSeq() + "&hasFile=" + view.getHasFile()
				+ "&currentPage=1";

		map.put("result", result);
		map.put("nextPage", result == 1 ? link : "/notice/list.do");
		return map;
	}

	@RequestMapping("/update.do")
	@ResponseBody // !!!!!!!!!!!! 비동기 응답
	public HashMap<String, Object> update(@ModelAttribute("BoardDto") BoardDto bDto, MultipartHttpServletRequest mReq) {

		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));

		}

		System.out.println("BDTO FDSDSFDS! " + bDto);

//		int result = bService.update(bDto, mReq.getFiles("attFiles"));

		HashMap<String, Object> map = new HashMap<String, Object>();

//		map.put("cnt", result);
//		map.put("msg", result == 1 ? "게시물 업데이트 완료!!!" : "게시물 업데이트 실패!!!");

		return map;
	}

	@RequestMapping("/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@ModelAttribute("BoardDto") BoardDto bDto, HttpSession session) {

		if (bDto.getTypeSeq() == 0) {
			bDto.setTypeSeq(Integer.parseInt(this.typeSeq));
		}
		// 비동기 리턴해줄 맵 생성
//		HashMap<String, Object> map = new HashMap<String, Object>();

		int result = bService.delete(bDto);
		System.out.println("RESULT IS HERE " + result);

		String link = "/notice/list.do?page=";

		if (bDto.getPage() == 0) {
			link += 1;
		} else {
			link += bDto.getPage();
		}

		HashMap<String, Object> map = new HashMap<>();
		System.out.println("THIS IS LINK!!!!! " + link);
		map.put("nextPage",
				result == 1 ? "/notice/list.do?page=" + bDto.getPage() : "/notice/list.do?page=" + bDto.getPage());
		return map;

	}

}
