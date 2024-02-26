package com.lhs.exception;

public class PasswordMissMatchException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String message = "";

	public PasswordMissMatchException() {
		super();
		setMessage("비밀번호가 일치하지 않습니다.");
	}

	public PasswordMissMatchException(String msg){
		this.setMessage(msg);
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
}
