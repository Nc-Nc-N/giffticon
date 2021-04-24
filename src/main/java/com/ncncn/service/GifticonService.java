package com.ncncn.service;

import com.ncncn.domain.PrcUpdateVO;

public interface GifticonService {

    public int gftDealCmpl(int gftId);

    public int deleteGifticon(int gftId);

    public int updateGftPrc(PrcUpdateVO prcUpdate);

	int countNotYetApproved();

	int countOnselling(String prdCode);

}
