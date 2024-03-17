package com.j0a0j.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.j0a0j.dto.MemberDto;
import com.j0a0j.exception.PasswordMissMatchException;
import com.j0a0j.exception.UserNotFoundException;

public interface MemberService {
	

	public ArrayList<HashMap<String, Object>> memberList(HashMap<String, Object> params);
	
	//총 회원수 for paging
	public int totalMemberCnt(HashMap<String, Object> params);

	public int join(MemberDto mDto);
	
	public int checkId(HashMap<String, String> params);

	public int delMember(HashMap<String,Object> params);

	MemberDto login(MemberDto mDto);
}
