package com.lhs.dao;

import org.springframework.stereotype.Repository;

import com.lhs.entity.EmailAuth;

@Repository
public interface EmailAuthDao {

	public int addEmailAuth(EmailAuth dto);
}
