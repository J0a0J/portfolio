package com.lhs.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.lhs.dto.MemberDto;

@Repository
public interface MemberDao {
	
	public ArrayList<HashMap<String, Object>> memberList(HashMap<String, Object> params);

	public int totalMemberCnt(HashMap<String, Object> params);

	public int join(MemberDto mDto);
	
	public int checkId(HashMap<String, String> params);
	
	public MemberDto getMemberById(MemberDto mDto);
	
	public String makeCipherText(HashMap<String, String> params);
	
	public int delMember(HashMap<String,Object> params);
	
}
