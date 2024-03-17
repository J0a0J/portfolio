package com.j0a0j.entity;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@Builder 
@ToString
//예를 들어 3개의 생성자가 필요하면 알아서 만든다.
@RequiredArgsConstructor  
@AllArgsConstructor
@Alias("EmailAuth")
public class EmailAuth {
	
	private int memberIdx;
	private int memberType;
	private String memberId;
	private String email;
	private String link;
	private String sendDtm;
}
