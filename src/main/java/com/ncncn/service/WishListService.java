package com.ncncn.service;

import com.ncncn.domain.WishListVO;

public interface WishListService {

	// 관심상품에 추가하기
	public int insertWish(WishListVO wish);

	// 관심상품에서 삭제하기
	public int deleteWish(WishListVO wish);

	// 관심상품이 있는지 조회
	public int hasWish(WishListVO wish);

}
