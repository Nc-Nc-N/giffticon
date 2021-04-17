package com.ncncn.mapper;

import org.apache.ibatis.annotations.Param;

public interface GifticonMapper {

    public int gftDealCmpl(int gftId);

    public int deleteGifticon(int gftId);

    public int updateGftPrc(@Param("gftId") int gftId,
                            @Param("isAutoPrc") char isAutoPrc,
                            @Param("dcPrc") int dcPrc);

	/* 판매요청 후 대기중인 기프티콘 개수 조회 */
	int countNotYetApproved();

}
