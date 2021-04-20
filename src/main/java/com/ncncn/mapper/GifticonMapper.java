package com.ncncn.mapper;

import java.util.List;
import java.util.Map;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import org.apache.ibatis.annotations.Param;

public interface GifticonMapper {

	GifticonVO read(int id);

	List<SaleRqustVO> readAllRqustWithPaging(SaleRqustCriteria cri);

	Map<String, String> readRqustById(int id);

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

}
