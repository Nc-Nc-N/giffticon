package com.ncncn.service;

import com.ncncn.mapper.GifticonMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

@Service
@Log4j
public class GifticonServiceImpl implements GifticonService {

	private GifticonMapper gifticonMapper;

	public GifticonServiceImpl(GifticonMapper gifticonMapper) {
		this.gifticonMapper = gifticonMapper;
	}

	@Override
	public int countNotYetApproved() {
		return gifticonMapper.countNotYetApproved();
	}

}
