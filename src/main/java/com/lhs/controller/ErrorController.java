package com.lhs.controller;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
	
	Logger logger = Logger.getLogger(ErrorController.class);

	@RequestMapping("/error/404.do")
	public ModelAndView pageNotFound(@RequestParam HashMap<String, String> params) {
		logger.debug("/error/404.do params : " + params);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("error/404");
		
		return mv;
	}
	
	@RequestMapping("/error/500.do")
	public ModelAndView exception(@RequestParam HashMap<String, String> params) {
		logger.debug("/error/500.do params : " + params);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("error/500");
		
		return mv;
	}
}
