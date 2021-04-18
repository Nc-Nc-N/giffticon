package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.WishListVO;
import com.ncncn.mapper.WishListMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class WishListServiceImpl implements WishListService{

	private WishListMapper mapper;

	@Override
	public int insertWish(WishListVO wish) {

		return mapper.insertWish(wish);
	}

	@Override
	public int deleteWish(WishListVO wish) {

		return mapper.deleteWish(wish);
	}

	@Override
	public int hasWish(WishListVO wish) {

		return mapper.hasWish(wish);
	}

	@Override
	public List<WishListVO> getWishList(int userId) {
		return mapper.getWishList(userId);
	}

	@Override
	public List<WishListVO> getWishListWithPaging(int userId, CriteriaSM cri) {
		return mapper.getWishListWithPaging(userId, cri.getAmount(), cri.getPageNum());
	}

	@Override
	public int getTotalCount(int userId) {
		return mapper.getTotalCount(userId);
	}
}
