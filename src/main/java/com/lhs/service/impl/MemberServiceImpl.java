package com.lhs.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lhs.dao.MemberDao;
import com.lhs.exception.PasswordMissMatchException;
import com.lhs.exception.UserNotFoundException;
import com.lhs.service.MemberService;
import com.lhs.util.Sha512Encoder;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired MemberDao mDao; 

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
		Sha512Encoder encoder = Sha512Encoder.getInstance();
		String encodePwd = encoder.getSecurePassword(pwd);
		params.put("memberPw", encodePwd);
		
		return mDao.join(params);
	}

	@Override
	public int checkId(HashMap<String, String> params) {
		return mDao.checkId(params);
	}

	@Override
	public HashMap<String, Object> login(HashMap<String, String> params) throws UserNotFoundException, PasswordMissMatchException {
		System.out.println("sibalsibal");
		HashMap<String, Object> member = mDao.getMemberById(params);
		if(member == null)  {
			member.put("e", "error occured");
			return member;
		}
		
		String memberPw = params.get("memberPw");
		String passwd = (String)member.get("memberPw");
		
		Sha512Encoder encoder = Sha512Encoder.getInstance();
		String encodePwd = encoder.getSecurePassword(passwd);
		System.out.println("EncodePwd   			" + encodePwd);
		
		if(StringUtils.pathEquals(passwd, encodePwd)) {
			return member;
		}
		else {
			member.put("e", "error occured");
			return member;
		}
	}

	@Override
	public int delMember(HashMap<String, Object> params) {	
		return mDao.delMember(params);
	}



	

}
