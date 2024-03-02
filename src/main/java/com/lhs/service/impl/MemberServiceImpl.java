package com.lhs.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lhs.dao.EmailAuthDao;
import com.lhs.dao.MemberDao;
import com.lhs.dto.EmailDto;
import com.lhs.dto.MemberDto;
import com.lhs.entity.EmailAuth;
import com.lhs.service.MemberService;
import com.lhs.util.EmailUtil;
import com.lhs.util.Sha512Encoder;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired MemberDao mDao; 
	@Autowired EmailUtil emailUtil;
	@Autowired EmailAuthDao emailAuthDao;
	
	@Override
	public ArrayList<HashMap<String, Object>> memberList(HashMap<String, Object> params) {
		return mDao.memberList(params);
	}
	
	//총회원수
	@Override
	public int totalMemberCnt(HashMap<String, Object> params) {
		return mDao.totalMemberCnt(params);
	}

	@Override
	public int join(HashMap<String, String> params) {
		
		String pwd = params.get("memberPw");
		String pwAgain = params.get("pwAgain");
		
		// 비밀번호 길이가 6보다 적을 때 
		if(pwd.length() < 6) {
			return 0;
		}
		
		// 비밀번호와 확인 비밀번호가 일치하지 않으면 바로 반환.
		if (!pwd.equals(pwAgain)) {
			return 0;
		}
		
		// 제약조건을 다 충족했기 때문에 여기서부터는 설정 과정.
		
		// DB에 암호화된 비밀번호를 넣기 위한 설정.
		Sha512Encoder encoder = Sha512Encoder.getInstance();
		String encodePwd = encoder.getSecurePassword(pwd);
		params.put("memberPw", encodePwd);
		
		int result = mDao.join(params);
		
		// 회원가입 후 인증 이메일을 보내기 위한 과정. 
//		String sMemberIdx = String.valueOf(params.get("memberIdx"));
//		int memberIdx = Integer.parseInt(sMemberIdx);
		MemberDto temp = new MemberDto();
		temp.setMemberId(params.get("memberId"));
		MemberDto mDto = mDao.getMemberById(temp);
		
		System.out.println("MEMBER DTO  	" + mDto);
		
		String link = UUID.randomUUID().toString();
		EmailAuth emailAuth = EmailAuth.builder()
				.memberIdx(mDto.getMemberIdx())
				.memberType(1)
				.memberId(params.get("memberId"))
				.email(params.get("email"))
				.link(link)
				.build();
		
		EmailDto emailDto = new EmailDto();
		emailDto.setFrom("j0a0j@naver.com");
		emailDto.setReceiver(params.get("email"));
		emailDto.setSubject("회원가입을 환영합니다.");
		String html = "<a href='https://github.com/J0a0J/portfolio'>인증하기</a>";
		emailDto.setText(html);
		
		try {
			emailUtil.sendMail(emailDto);
			emailAuthDao.addEmailAuth(emailAuth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
	}

	@Override
	public int checkId(HashMap<String, String> params) {
		return mDao.checkId(params);
	}

	@Override
	public MemberDto login(MemberDto mDto) {
		MemberDto m = mDao.getMemberById(mDto);
		// DB에 입력한 ID가 없다면 바로 반환.
		if (m == null) return null;
		
		// DB에 저장된 ID의 비밀번호 불러오기 
		String memberPw = m.getMemberPw();
		// 입력한 비밀번호 불러오기 
		String passwd = mDto.getMemberPw();
		Sha512Encoder encoder = new Sha512Encoder();
		
		// 입력한 비밀번호 암호화 하기 <- DB 저장된 비밀번호와 비교하기 위해 
		String encodePw = encoder.getSecurePassword(passwd);
		// 비밀번호 동일한지 확인 
		boolean ok = StringUtils.pathEquals(memberPw, encodePw);
		
		return (ok == true) ? m : null; 
	}

	@Override
	public int delMember(HashMap<String, Object> params) {	
		return mDao.delMember(params);
	}

}
