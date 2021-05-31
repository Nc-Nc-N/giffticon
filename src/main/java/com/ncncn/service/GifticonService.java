package com.ncncn.service;

import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.pagination.GiftiCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GifticonService {
	// 구매할 기프티콘
	public ProdListVO getGifticon(int id);

    public int gftDealCmpl(int gftId);

    public int deleteGifticon(int gftId);

    public int updateGftPrc(PrcUpdateVO prcUpdate);

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
	public List<ProdListVO> getDeadlineGifti(GiftiCriteria cri);

	public int getDeadTotal();

	public void registerGifticon(GifticonVO gifticon);

	//map 출력용 대표 기프티콘
	public List<ProdListVO> getMainGftByBrandName(String brdName);

	// 기프티콘 상태 변경(판매중 -> 거래확정대기)
	public boolean updateGftStus(int id);

	public GifticonVO getGft(int id);

	public int checkGft(@Param("gftId") int gftId, @Param("userId") int userId);

	public GifticonVO checkValidPrc(int gftId, int dcPrcVal);
}
