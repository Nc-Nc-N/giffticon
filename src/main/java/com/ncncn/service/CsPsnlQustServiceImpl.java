package com.ncncn.service;

import com.ncncn.mapper.CsPsnlQustMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

@Service
@Log4j
public class CsPsnlQustServiceImpl implements CsPsnlQustService {

	private CsPsnlQustMapper csPsnlQustMapper;

	public CsPsnlQustServiceImpl(CsPsnlQustMapper csPsnlQustMapper) {
		this.csPsnlQustMapper = csPsnlQustMapper;
	}

	@Override
	public int countHaveNoAns() {
		return csPsnlQustMapper.countHaveNoAns();
	}

}
