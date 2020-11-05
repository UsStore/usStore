package com.example.usStore.dao.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.AccountDao;
import com.example.usStore.dao.mybatis.mapper.AccountMapper;
import com.example.usStore.dao.mybatis.mapper.AttendanceMapper;
import com.example.usStore.domain.Account;

@Transactional
@Repository
public class MybatisAccountDao implements AccountDao {

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AttendanceMapper attendanceMapper;
	
	public Account getAccountByUserId(String username) throws DataAccessException {
		return accountMapper.getAccountByUserId(username);
	}
	
	@Override
	public Account getAccountByUsername(String username) throws DataAccessException {
		// TODO Auto-generated method stub
		return accountMapper.getAccountByUsername(username);
	}

	public Account getAccountByUserIdAndPassword(String userId, String password) 
			throws DataAccessException {
		return accountMapper.getAccountByUserIdAndPassword(userId, password);
	}

	public void insertAccount(Account account) throws DataAccessException {
		accountMapper.insertAccount(account);
	}

	public void updateAccount(Account account) throws DataAccessException {
		accountMapper.updateAccount(account);
		if (account.getPassword() != null && account.getPassword().length() > 0) 
		{
			accountMapper.updateAccount(account);
		}
	}
	
	//포인트 & 날짜 출석 트랜잭션
	@Override
	public void updatePoint(String userId, int point) {
		accountMapper.updatePoint(userId, point);
		attendanceMapper.insertAttend(userId);
	}
	
	public int getPointByUserId(String userId) {
		return accountMapper.getPointByUserId(userId);
	}
}