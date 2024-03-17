package com.j0a0j.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.j0a0j.dao.EmailAuthDao;
import com.j0a0j.dao.MemberDao;
import com.j0a0j.dto.EmailDto;
import com.j0a0j.dto.MemberDto;
import com.j0a0j.entity.EmailAuth;
import com.j0a0j.service.MemberService;
import com.j0a0j.util.EmailUtil;
import com.j0a0j.util.Sha512Encoder;

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
	public int join(MemberDto mDto) {
//		
		String pwd = mDto.getMemberPw();
		String pwAgain = mDto.getPwAgain();
		
		
		// 비밀번호 길이가 6보다 적을 때 
		if(pwd.length() < 6) {
			return 0;
		}
		
		// 비밀번호와 확인 비밀번호가 일치하지 않으면 바로 반환.
		if (!pwd.equals(pwAgain)) {
			System.out.println("PWD   !!!!!!!!!!!          !!!!" + pwd);
			System.out.println("PWD   !!!!!!!!!!!          !!!!" + pwAgain);
			return 0;
		}
		
		// 제약조건을 다 충족했기 때문에 여기서부터는 설정 과정.
		
		// DB에 암호화된 비밀번호를 넣기 위한 설정.
		Sha512Encoder encoder = Sha512Encoder.getInstance();
		String encodePwd = encoder.getSecurePassword(pwd);
		mDto.setMemberPw(encodePwd);
		
		System.out.println("MEMBER IDX IS !!!!!!!!!!!!!!!!!    " + mDto.getMemberIdx());
		
		int result = mDao.join(mDto);
		System.out.println("THIS IS RESULT         " + result);
		
		// 회원가입 후 인증 이메일을 보내기 위한 과정. 
//		String sMemberIdx = String.valueOf(params.get("memberIdx"));
//		int memberIdx = Integer.parseInt(sMemberIdx);
//		MemberDto temp = new MemberDto();
//		temp.setMemberId(mDto.getMemberId());
//		MemberDto mDto = mDao.getMemberById(temp);
		
		System.out.println("MEMBER DTO  	" + mDto);
		
		String link = UUID.randomUUID().toString();
		EmailAuth emailAuth = EmailAuth.builder()
				.memberIdx(mDto.getMemberIdx())
				.memberType(1)
				.memberId(mDto.getMemberId())
				.email(mDto.getEmail())
				.link(link)
				.build();
		
		EmailDto emailDto = new EmailDto();
		emailDto.setFrom("j0a0j@naver.com");
		emailDto.setReceiver(mDto.getEmail());
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
