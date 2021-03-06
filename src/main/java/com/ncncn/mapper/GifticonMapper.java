package com.ncncn.mapper;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.GiftiCriteria;
import com.ncncn.domain.pagination.SaleGftCriteria;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface GifticonMapper {

	GifticonVO read(int id);

	// 구매할 기프티콘
	ProdListVO getGifticon(int id);

	List<SaleRqustVO> readAllRqustWithPaging(SaleRqustCriteria cri);

	Map<String, Object> readRqustById(int id);

	int countAllRqust(SaleRqustCriteria cri);

	int updateSaleRqust(@Param("gftId") int id,
						@Param("prodCode") String prodCode,
						@Param("dcPrc") int dcPrc,
						@Param("dcRate") double dcRate);

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
	public List<ProdListVO> getDeadlineGifti(GiftiCriteria cri);

	public int getDeadTotal();

	public void registerGifticon(GifticonVO gifticon);

	public void insertDcPrcHist(GifticonVO gifticon);

	public int getGftIdByBarcode(String brcd);

	public void updateDcPrcHist(int id);

	public int getDcPrcHistIdByGftId(PrcUpdateVO prcUpdateVO);

	//지도 - 메인기프티콘
	public List<ProdListVO> getMainGftByBrandName(String brdName);

	// 기프티콘 상태 변경(판매중 -> 거래확정대기)
	public boolean updateGftStus(int id);
  
  public List<AutoPriceVO> getAutoPricedGifticon();

	public List<GifticonVO> getOnSaleGifticon();

	public void disableExpiredGifticon(int id);

//	public void updateAutoPrice(int id, int dcPrc, double dcRate);
	public void updateAutoPrice(AutoPriceVO autoPriceVO);

	// 어제 업로드된 바코드 이미지 파일 목록
	public List<BarcodeInfoVO> getYesterdayBarcodeImageInfo();

	List<Map<String, Object>> getAllSaleGifticon(SaleGftCriteria cri);

	Map<String, Object> getSaleGifticon(int gftId);

	int countAllSaleGft(SaleGftCriteria cri);

	int updateSaleGftStus(@Param("id") int id, @Param("stus") String stus);

	List<DealDetailVO> getNotCmplGft();

	int autoDealCmpl(List<DealDetailVO> gftList);

	public int checkGft(@Param("gftId") int gftId, @Param("userId") int userId);

	public GifticonVO checkValidPrc(@Param("gftId") int gftId);

}
