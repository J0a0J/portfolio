package com.lhs.util;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.lhs.dto.EmailDto;

@Component
public class EmailUtil {
	
	private JavaMailSender mailSender;
	
	public EmailUtil(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	private String sendMail(EmailDto email, boolean isHtml) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setTo(email.getReceiver());
			messageHelper.setText(email.getText(), true);
			messageHelper.setFrom(email.getFrom());
			messageHelper.setSubject(email.getSubject());	// 메일제목은 생략이 가능하다

			mailSender.send(message);

		} catch(Exception e){
			System.out.println(e);
			return "Error";
		}
		return "Sucess";
	}

	public String sendMail(EmailDto email) {
		return sendMail(email, false);
	}
	
	public String sendHtmlMail(EmailDto email) {
		return sendMail(email, true);
	}
}
