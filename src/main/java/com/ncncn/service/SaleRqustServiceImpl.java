package com.ncncn.service;

import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.mapper.GifticonMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Log4j
public class SaleRqustServiceImpl implements SaleRqustService {

	private GifticonMapper gifticonMapper;

	public SaleRqustServiceImpl(GifticonMapper gifticonMapper) {
		this.gifticonMapper = gifticonMapper;
	}

	@Override
	public List<SaleRqustVO> getAllRqust(SaleRqustCriteria cri) {
		return gifticonMapper.readAllRqustWithPaging(cri);
	}

	@Override
	public Map<String, Object> getRqustById(int id) {
		Map<String, Object> saleRqust = gifticonMapper.readRqustById(id);

		if (saleRqust == null || saleRqust.size() == 0) {
			log.warn("해당 판매요청이 존재하지 않습니다.");
			throw new NullPointerException("해당 판매요청이 존재하지 않습니다.");
		}

		return saleRqust;
	}

	@Override
	public int getTotalCount(SaleRqustCriteria cri) {
		return gifticonMapper.countAllRqust(cri);
	}

	@Override
	public int modifyStusCodeAndAprvDt(int id) {
		return gifticonMapper.updateStusCodeAndAprvDt(id);
	}

	@Override
	public int removeRqust(int id) {
		return gifticonMapper.deleteGifticon(id);
	}

}
