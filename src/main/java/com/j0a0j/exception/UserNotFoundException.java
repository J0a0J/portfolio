package com.j0a0j.exception;

public class UserNotFoundException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4849492192851389514L;
	
	private String message = "";

	public UserNotFoundException() {
		super();
		setMessage("사용자를 찾을 수 없습니다.");
	}

	public UserNotFoundException(String msg){
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
