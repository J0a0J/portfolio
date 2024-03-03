package com.lhs.util;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

//물리적 위치로 파일 저장 

public class FileUtil {
	
	private Logger logger = Logger.getLogger(FileUtil.class);
	
	// config.ini 에 설정해둔 값을 찾아서 사용한다. (물리적)	
	@Value("#{config['project.file.upload.location']}")
	private String saveLocation;
	
	
/* 베포용 : saveLocation = "/home/ubuntu/app/upload/" ;
   개발용 : saveLocation = "/Users/hyesuelee/Documents/portfolio_dir/";  */
	
	public void setLocation(String location) {
		this.saveLocation = location;
	}
	
	/**
	 * 파일 복사(저장) 
	 */
	public void copyFile(MultipartFile mf, String fakename) throws IOException {
		//1. 디렉토리(폴더) 지정.
		File destDir = new File(this.saveLocation);// 지정 
		if(!destDir.exists()) {	//존재하지 않으면 
			destDir.mkdirs();//만들라 
		}
		// 2. 파일 지정 [저장 디렉토리 (경로담긴), 저장할 파일명] 
		File destFile = new File(destDir, fakename);// (저장할 폴더,저장할 파일명) 
		
		//FileCopyUtils.copy([file data], target(디렉토리, 파일명);
		//FileCopyUtils 활용하여 임시저장된 사진파일을 지정한 위치로 복사한다(물리적 위치에 실제저장). 
		FileCopyUtils.copy(mf.getBytes(), destFile);		
	}

	/**
	 * 파일 읽기(다운로드) 
	 */
	public byte[] readFile(HashMap<String, Object> fileInfo) {
		//1. 파일 찾기 File(파일위치, 파일명)  
		File f = new File(saveLocation, String.valueOf(fileInfo.get("fake_file_name")));// 파일명 페이크네임으로 저장되어있으므로. 
		byte[] fileByte = null;
		if(f.exists()) { // 물리적 위치에 존재하면
			// 파일 byte단위로 읽어온다.
			try {
				fileByte = FileUtils.readFileToByteArray(f);
				// FileUtils.readFileToByteArray: byte단위로 읽어들여 배열에 저장한다. 
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else {	// 물리적 위치에 파일 없음
			// 
		}
		return fileByte;  // 바이트 배열의 파일 리턴.. 
	}
	
	/* 파일 삭제 */
	public boolean deleteFile(HashMap<String, Object> fileInfo) {
		//1. 파일 찾기 File(파일위치, 파일명)  
		File f = new File(saveLocation, String.valueOf(fileInfo.get("fake_file_name")));
		if(f.exists()) { // 물리적 위치에 존재하면
			return f.delete();	// 지우라.
			
		}
		return false;// 존재하지않으면 false 반환 
	}
	

	
	
}
