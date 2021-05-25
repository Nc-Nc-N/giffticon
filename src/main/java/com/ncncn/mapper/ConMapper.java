package com.ncncn.mapper;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConMapper {

    public void accRegister(BankAccountVO bankAccountVO);

    public int accUpdate(BankAccountVO bankAccountVO);

    // 콘 내역 db에 저장
    public boolean insertConHist(PntHistVO pntHistVO);

    // user pnt update
    public boolean updateUserCon(@Param("userId") int userId,
                              @Param("balance") int balance);

    // 콘 내역 조회
    public List<PntHistVO> getConHistWithPaging(@Param("userId") int userId,
                                                @Param("amount") int amount,
                                                @Param("pageNum") int pageNum,
                                                @Param("dateFrom") String dateFrom,
                                                @Param("dateTo") String dateTo,
                                                @Param("type") String type,
                                                @Param("typeArr") String[] typeArr);

    public int getConTotal(@Param("userId") int userId,
                           @Param("dateFrom") String dateFrom,
                           @Param("dateTo") String dateTo,
                           @Param("type") String type,
                           @Param("typeArr") String[] typeArr);

    // user pnt update
    public boolean manualDealCmpl(@Param("userId") int userId,
                                 @Param("balance") int balance);
}
