package com.ncncn.service;

public interface GifticonService {

    public int gftDealCmpl(int gftId);

    public int deleteGifticon(int gftId);

    public int updateGftPrc(int gftId, char isAutoPrc, int dcPrc, double dcRate);

	int countNotYetApproved();

	int countOnselling(String prdCode);

}
