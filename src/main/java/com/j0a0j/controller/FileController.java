package com.j0a0j.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileController {

	@Autowired ApplicationContext context;

	@RequestMapping("/file/downloadERD.do")
	@ResponseBody
	public byte[] downloadERD(HttpServletResponse rep) {

		File file;
		try {
			file = context.getResource("classpath:files/portfolio_ERD.mwb").getFile();

			rep.setHeader("Content-Disposition", "attachment; filename=\""+file.getName()+"\"");
			rep.setHeader("Prama", "no-cache");
			rep.setHeader("Cache-Control", "no-cache");
			rep.setContentLength((int) file.length());

			return FileUtils.readFileToByteArray(file);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;	

	}

}
