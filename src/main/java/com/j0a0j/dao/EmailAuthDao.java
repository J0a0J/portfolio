package com.j0a0j.dao;

import org.springframework.stereotype.Repository;

import com.j0a0j.entity.EmailAuth;

@Repository
public interface EmailAuthDao {

	public int addEmailAuth(EmailAuth dto);
}
