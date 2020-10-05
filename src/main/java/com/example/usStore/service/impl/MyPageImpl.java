package com.example.usStore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.AccuseDao;
import com.example.usStore.dao.UniversityDao;
import com.example.usStore.domain.Accuse;
import com.example.usStore.domain.University;
import com.example.usStore.service.facade.MyPageFacade;


@Repository
@Service("mypageImpl")
@Transactional
public class MyPageImpl implements MyPageFacade {
	@Autowired
	private AccuseDao accuseDao;
	
	@Autowired
	private UniversityDao univDao;
	
	@Override
	public void insertAccuse(Accuse accuse) {
		accuseDao.insertAccuse(accuse);
	}

	@Override
	public int countAccuseById(String accountId) {
		return accuseDao.countAccuseById(accountId);
	}

	@Override
	public String isAccuseAlready(String attacker, String victim) {
		return accuseDao.isAccuseAlready(attacker, victim);
		
	}

	@Override
	public List<Accuse> selectAccuseList(String victim) {
		return accuseDao.selectAccuseList(victim);
	}

	@Override
	public University getUnivByName(String univNameU) {
		return univDao.getUnivByName(univNameU);
	}

	@Override
	public void insertUniv(University university) {
		univDao.insertUniv(university);
	}
}
