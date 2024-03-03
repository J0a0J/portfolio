package com.lhs.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileDto {
	int board_seq;
	int type_seq;
	String member_id;
	String member_nick;
	String title;
	String content;
	String has_file;
	int hits;
	String create_dtm;
	String update_dtm;
}
