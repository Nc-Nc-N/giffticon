package com.ncncn.mapper;

import com.ncncn.domain.AdminDealHistVO;
import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class HistoryMapperTests {

    @Setter(onMethod_ = @Autowired)
    private HistoryMapper historyMapper;

    @Test
    public void testPaging() {
        AdminDealHistCriteria cri = new AdminDealHistCriteria();
        cri.setPageNum(2);

        List<AdminDealHistVO> list = historyMapper.getAdminDealHistWithPaging(cri);

        list.forEach(board -> log.info(board));
    }

    @Test
    public void testConPaging() {
        AdminConHistCriteria cri = new AdminConHistCriteria();
        List<Map<String, String>> list = historyMapper.getAdminConHistWithPaging(cri);

        list.forEach(board -> log.info(board));
    }
}
