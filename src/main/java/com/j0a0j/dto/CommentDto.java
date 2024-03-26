package com.j0a0j.dto;

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
public class CommentDto {
	private int typeSeq;
	private int boardSeq;
	private String replyContent;
	private int memberIdx;
	private String memberNick;
	private String createDtm;
}
