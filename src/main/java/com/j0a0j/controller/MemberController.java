package com.j0a0j.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.j0a0j.dto.MemberDto;
import com.j0a0j.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {

	@Autowired
	MemberService mService;

	@Value("#{config['site.context.path']}")
	String ctx;

	@RequestMapping("/member/goLoginPage.do")
	public String goLogin() {
		return "member/login";
	}

	@RequestMapping("/member/goRegisterPage.do")
	public String goRegisterPage() {
		return "member/register";
	}

	@RequestMapping("/member/checkId.do")
	@ResponseBody
	public HashMap<String, Object> checkId(@RequestParam HashMap<String, String> params){
		int cnt = 0;
		HashMap<String, Object> map = new HashMap<String, Object>();
		// 아이디 중복 체크 
		cnt = mService.checkId(params);
		map.put("cnt", cnt);
		map.put("msg", cnt==1? "중복된 ID 입니다.":"중복 ㄴ");

		return map;
	}

	@RequestMapping("/member/join.do")
	@ResponseBody
	public HashMap<String, Object> join(@ModelAttribute("MemberDto") MemberDto mDto){		
		System.out.println("This is MDTO          " + mDto);
		int cnt = 0;
		cnt = mService.join(mDto);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		map.put("msg", cnt==1?"회원 가입 완료!":"회원 가입 실패!");
		map.put("nextPage", cnt==1?"/member/goLoginPage.do" : "/member/goRegisterPage.do");
		
		return map;
	}

	@RequestMapping("/member/logout.do")
	public ModelAndView logout(HttpSession session){
		// 세션 삭
		session.removeAttribute("memberId");
		session.invalidate();
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("/pf/index.do");
		mv.setView(rv);		
		return mv;
	}

	@RequestMapping("/member/login.do")
	@ResponseBody
	public HashMap<String, Object> login(@ModelAttribute("MemberDto") MemberDto mDto, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			MemberDto m = mService.login(mDto);	
			System.out.println("MEMBER LOGIN 				"+m);

			// 입력한 아이디가 없거나 비밀번호가 일치하지 않으면 에러 처리 
			if (mDto == null) {
				throw new Exception();
			}
			
			// 세션 설정 
			session.setAttribute("memberId", m.getMemberId());
			session.setAttribute("memberNick", m.getMemberNick());
			session.setAttribute("memberIdx", m.getMemberIdx());
			session.setMaxInactiveInterval(60 * 60 * 24);
			
			map.put("nextPage", "/index.do");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("", e);
			map.put("nextPage", "/login.do");
			map.put("msg", "아이디 또는 비밀번호 입력을 잘못했습니다.");
		}
		return map;
	}

	@RequestMapping("/admin/memberList.do")
	@ResponseBody //비동기식 호출
	public HashMap<String, Object> memberList(@RequestParam HashMap<String, Object> params) {
		// 페이징
		// 모든 회원 가져오기
		List<HashMap<String,Object>> memberList = new ArrayList<HashMap<String,Object>>();
		
		//go to  JSP 

		HashMap<String,Object> result = new HashMap<String,Object>();
		//정해진  키 이름으로 넘겨주기.. 
		result.put("page", params.get("page")); //현재 페이지 
		result.put("rows", memberList); // 불러온 회원목록 
		result.put("total", 1);// 전체 페이지 
		result.put("records", 10); //전체 회원수 

		return result;

	}

	@RequestMapping("/member/delMember.do")
	@ResponseBody
	public HashMap<String,Object> delMember(@RequestParam HashMap<String, Object> params){
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = 0;
		map.put("msg", (result == 1) ? "삭제되었습니다.":"삭제 실패!");
		map.put("result",result);
		return map;

	}

}
