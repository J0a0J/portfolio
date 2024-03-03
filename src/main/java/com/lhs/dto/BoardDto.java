package com.lhs.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@RequiredArgsConstructor  
@AllArgsConstructor
@Alias("board")
public class BoardDto {
	int boardSeq;
	int typeSeq;
	String memberId;
	String memberNick;
	String title;
	String content;
	String hasFile;
	String createDtm;
	int hits;
}
