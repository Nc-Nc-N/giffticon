package com.ncncn.mapper;

import com.ncncn.domain.WishListVO;

import java.util.List;

public interface WishListMapper {

	// 관심상품에 추가하기
	public int insertWish(WishListVO wish);

	// 관심상품에서 삭제하기
	public int deleteWish(WishListVO wish);

	// 관심상품이 있는지 조회
	public int hasWish(WishListVO wish);

	// 유저 - 관심상품 조회
	public List<WishListVO> getWishList(int userId);

}
