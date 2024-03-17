package com.j0a0j.dto;

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
@Alias("board_attach")
public class FileDto {
	private int boardSeq;
	private int fileIdx;
	private int typeSeq;
	private int fileSize;
	private String fileName;
	private String fakeFileName;
	private String fileType;
	private String saveLoc;
	private String createDtm;
	
	
}
