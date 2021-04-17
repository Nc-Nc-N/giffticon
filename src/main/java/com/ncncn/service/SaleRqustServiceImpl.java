package com.ncncn.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.mapper.GifticonMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

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
	public Map<String, String> getRqustById(int id) {
		Map<String, String> saleRqust = gifticonMapper.readRqustById(id);
		GifticonVO gifticonVO = gifticonMapper.read(id);

		if (saleRqust == null || saleRqust.size() == 0 || gifticonVO == null) {
			log.info("해당 판매요청이 존재하지 않습니다.");
			throw new NullPointerException("해당 판매요청이 존재하지 않습니다.");
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		saleRqust.put("gftId", String.valueOf(gifticonVO.getId()));
		saleRqust.put("prodCode", gifticonVO.getProdCode());
		saleRqust.put("dcPrc", String.valueOf(gifticonVO.getDcPrc()));
		saleRqust.put("dcRate", String.valueOf(gifticonVO.getDcRate()));
		saleRqust.put("expirDt", format.format(gifticonVO.getExpirDt()));
		saleRqust.put("brcd", gifticonVO.getBrcd());
		saleRqust.put("descn", gifticonVO.getDescn());
		saleRqust.put("imgPath", gifticonVO.getImgPath());
		saleRqust.put("isAutoPrc", String.valueOf(gifticonVO.getIsAutoPrc()));
		saleRqust.put("inDate", format.format(gifticonVO.getInDate()));

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
		return gifticonMapper.deleteById(id);
	}

}
