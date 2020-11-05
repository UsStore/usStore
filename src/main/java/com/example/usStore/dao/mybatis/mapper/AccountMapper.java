package com.example.usStore.dao.mybatis.mapper;
import com.example.usStore.domain.Account;

public interface AccountMapper {

	// userId로 Account 가져오기
	Account getAccountByUserId(String userId);
	
	// username으로 Account 가져오기
	Account getAccountByUsername(String username);
	
	// userId랑 password로 Account 가져오기
	Account getAccountByUserIdAndPassword(String userId, String password);
	
	// 계정 추가
	void insertAccount(Account account);
	
	// 계정 수정
	void updateAccount(Account account);
	
	//포인트 적립
	void updatePoint(String userId, int point);
	
	//보유 포인트 조회
	int getPointByUserId(String userId);
}
