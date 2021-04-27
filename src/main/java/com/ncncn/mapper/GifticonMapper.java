package com.ncncn.mapper;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.GiftiCriteria;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface GifticonMapper {

	GifticonVO read(int id);

	List<SaleRqustVO> readAllRqustWithPaging(SaleRqustCriteria cri);

	Map<String, Object> readRqustById(int id);

	int countAllRqust(SaleRqustCriteria cri);

	int updateStusCodeAndAprvDt(int id);

	int gftDealCmpl(int gftId);

	int deleteGifticon(int gftId);

	int updateGftPrc(@Param("gftId") int gftId,
					 @Param("isAutoPrc") char isAutoPrc,
					 @Param("dcPrc") int dcPrc,
					 @Param("dcRate") double dcRate);

	/* 판매요청 후 대기중인 기프티콘 개수 조회 */
	int countNotYetApproved();

	int countOnselling(String prdCode);

	// 기프티콘 목록(페이징 처리)
	public List<ProdListVO> getGiftiWithPaging(GiftiCriteria cri);

	// 전체 데이터의 개수 처리
	public int getTotalCount(GiftiCriteria cri);

	// 기프티콘 목록
	public List<ProdListVO> getGiftiList(String code);

	// 기프티콘 하나
	public ProdListVO getGifti(String code);

	// 인기상품 목록
	public List<ProdListVO> getBestGifti();

	// 마감임박 상품 목록
	public List<ProdListVO> getDeadlineGifti();

	public void registerGifticon(GifticonVO gifticon);

}
