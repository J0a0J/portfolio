package com.lhs.dto;

import org.apache.ibatis.type.Alias;

public class MemberDto {
	
	Integer memberIdx;
	private Integer typeSeq;
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberNick;
	private String email;
	private String createDtm;
	private String updateDtm;
	private String membercol;
	
	
	public Integer getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(Integer memberIdx) {
		this.memberIdx = memberIdx;
	}
	public Integer getTypeSeq() {
		return typeSeq;
	}
	public void setTypeSeq(Integer typeSeq) {
		this.typeSeq = typeSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCreateDtm() {
		return createDtm;
	}
	public void setCreateDtm(String createDtm) {
		this.createDtm = createDtm;
	}
	public String getUpdateDtm() {
		return updateDtm;
	}
	public void setUpdateDtm(String updateDtm) {
		this.updateDtm = updateDtm;
	}
	public String getMembercol() {
		return membercol;
	}
	public void setMembercol(String membercol) {
		this.membercol = membercol;
	}
	
	@Override
	public String toString() {
		return "MemberDto [memberIdx=" + memberIdx + ", typeSeq=" + typeSeq + ", memberId=" + memberId + ", memberPw="
				+ memberPw + ", memberName=" + memberName + ", memberNick=" + memberNick + ", email=" + email
				+ ", createDtm=" + createDtm + ", updateDtm=" + updateDtm + ", membercol=" + membercol + "]";
	}
	
	
	
}
