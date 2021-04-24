package com.ncncn.service;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.pagination.GiftiCriteria;

import java.util.List;

public interface GifticonService {

    public int gftDealCmpl(int gftId);

    public int deleteGifticon(int gftId);

    public int updateGftPrc(int gftId, char isAutoPrc, int dcPrc, double dcRate);

	int countNotYetApproved();

	int countOnselling(String prdCode);

	// 기프티콘 목록(페이징 처리)
	public List<ProdListVO> getGiftiWithPaging(GiftiCriteria cri);

	// 전체 데이터의 개수 처리
	public int getTotal(GiftiCriteria cri);

	// 기프티콘 목록
	public List<ProdListVO> getGiftiList(String code);

	// 기프티콘 하나
	public ProdListVO getGifti(String code);

	// 인기상품 목록
	public List<ProdListVO> getBestGifti();

	// 마감상품 목록
	public List<ProdListVO> getDeadlineGifti();

	public void registerGifticon(GifticonVO gifticon);
}
