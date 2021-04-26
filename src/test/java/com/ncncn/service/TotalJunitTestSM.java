package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.pagination.GiftiCriteria;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class TotalJunitTestSM {

    @Autowired
    FaqService faqService;

    @Autowired
    NoticeService noticeService;

    @Autowired
    StatisticsService statisticsService;

    @Autowired
    UserService userService;

    @Autowired
    SignUpService signUpService;

    @Autowired
    GifticonService giftiService;

    @Test
    public void FaQTest(){

        CsFaqVO faq = faqService.get(1);

        log.info(faq.toString());

        assertEquals(faq.getUserId(), 166);
        assertEquals(faq.getQust(), "구매 자주묻는질문");
        assertEquals(faq.getEnabled(),1);
        assertEquals(faq.getCsCateCode(),"001");
    }

    @Test
    public void FaQTest2(){

        CsFaqVO faqmod = new CsFaqVO();

        faqmod.setId(20);
        faqmod.setEnabled('1');
        faqmod.setCsCateCode("002");
        faqmod.setQust("판매 테스트 질문SM");
        faqmod.setAns("판매 테스트 답변SM");
        faqmod.setUserId(156);
        faqmod.setOdrNo(3);
        boolean modCmpl = faqService.modify(faqmod);

        assertTrue(modCmpl);
    }

    @Test
    public void FaQTest3(){

        boolean faqdel = faqService.remove(9999);

        assertFalse(faqdel);
    }

    @Test
    public void FaQTest4(){

        boolean faqdel = faqService.remove(21);

        assertTrue(faqdel);
    }

    @Test
    public void FaQTest5(){

        CsCriteria cri = new CsCriteria();

        cri.setAmount(10);
        cri.setPageNum(1);
        int totalFaq = faqService.getTotal(cri);

        assertEquals(totalFaq, 67);
    }

    @Test
    public void FaQTest6(){

        CsFaqVO csNew = new CsFaqVO();

        csNew.setOdrNo(1);
        csNew.setQust("테스트 질문 FAQ");
        csNew.setUserId(157);
        csNew.setEnabled('1');
        csNew.setCsCateCode("001");
        csNew.setAns("테스트 답변 완료 FAQ");

        faqService.register(csNew);

        CsFaqVO csget = faqService.get(72);
        log.info(csget.toString());
        log.info(csNew.getId());

        assertEquals(csget.getQust(),csNew.getQust());
        assertEquals(csget.getEnabled(),csNew.getEnabled());
        assertEquals(csget.getAns(),csNew.getAns());
    }

    @Test
    public void ProdTest1(){

        GiftiCriteria cri = new GiftiCriteria();
        cri.setAmount(20);
        cri.setCode("0202");

        int prodSize = giftiService.getGiftiWithPaging(cri).size();

        assertEquals(prodSize,10);
    }

    @Test
    public void ProdTest2(){

       List<ProdListVO> getList = giftiService.getGiftiList("010101");

       assertEquals(getList.size(), 3);
       assertEquals(getList.get(2).getId(), 2);
       assertEquals(getList.get(1).getId(), 7);
       assertEquals(getList.get(0).getId(), 161);
       assertEquals(getList.get(0).getDcPrc(), 3560);
    }

    @Test
    public void NoticeTest1(){

        CsCriteria cri = new CsCriteria();

        cri.setAmount(10);
        cri.setPageNum(1);
        int getTotal = noticeService.getTotal(cri);

        assertEquals(getTotal, 78);
    }

    @Test
    public void NoticeTest2(){

        CsCriteria cri = new CsCriteria();

        cri.setAmount(10);
        cri.setPageNum(1);
        List<CsNoticeVO> getList = noticeService.getList(cri);

        assertEquals(getList.size(), 10);
    }

    @Test
    public void NoticeTest3(){

        CsNoticeVO notice = new CsNoticeVO();

        notice.setCsCateCode("004");
        notice.setCntnt("테스트용 notice 20210417 오후 11:39 저녁뚝딱 테스트 코드 작성중 SM");
        notice.setTitle("테스트 코드 작성중입니다 SM");
        notice.setIsFixed('1');
        notice.setEndDt(new Date());
        notice.setUserId(156);

        noticeService.register(notice);

        CsNoticeVO getNotice = noticeService.get(216);

        assertEquals(getNotice.getId(),216);
        assertEquals(getNotice.getCntnt(),notice.getCntnt());
        assertEquals(getNotice.getCsCateCode(),notice.getCsCateCode());
        assertEquals(getNotice.getUserId(),notice.getUserId());
    }

    @Test //total 숫자가 194가 나와야 하는데...? - db값 code 잘못 들어가서 total 79 가 맞음
    public void NoticeTest4(){

        CsCriteria cri = new CsCriteria();
        cri.setAmount(10);
        cri.setPageNum(1);
        cri.setType("NE");

        int total = noticeService.getTotal(cri);

        assertEquals(total, 79);
    }

    @Test
    public void NoticeTest5(){

        CsNoticeVO notice = noticeService.get(216);

        notice.setUserId(157);
        notice.setCntnt("등록 후 수정테스트를 거친 테스트 컨텐츠 입니다 SM");
        notice.setTitle("등록 후 수정테스트를 거친 테스트 제목 입니다 2021-04-18 12:04 오늘은 일요일 SM");
        notice.setCsCateCode("003");

        boolean update = noticeService.modify(notice);

        assertTrue(update);
    }

    @Test
    public void UserCheckTest1(){

        UserCheckCriteria cri = new UserCheckCriteria(1,10);

        List<UserVO> userList = userService.getUserList(cri);

        assertEquals(userList.size() , 10);
    }

    @Test
    public void UserCheckTest2(){

        UserDetailCheckVO user = userService.getUserDetail(156);

        assertEquals(user.getId(), 156);
        assertEquals(user.getEmail(), "planner263@gmail.com");
        assertEquals(user.getEnabled(),1);
        assertEquals(user.getMemo(),null);
    }

    @Test
    public void UserCheckTest3(){

        UserMemoVO memo = new UserMemoVO();
        memo.setMemo("테스트용 메모입니다 유저에 메모 삽입 (user객체 에 update문 안쓰고 따로 메모 DTO 를 만드신건가요???)- SM");
        memo.setId(156);

        userService.updateMemo(memo);

        UserDetailCheckVO user = userService.getUserDetail(156);

        assertEquals(user.getMemo(),memo.getMemo());
    }

    @Test
    public void UserCheckTest4(){

        UserStatusVO userStus = new UserStatusVO();

        userStus.setEnabled('2');
        userStus.setId(44);

        userService.updateStatus(userStus);

        UserDetailCheckVO user = userService.getUserDetail(44);

        assertEquals(user.getEnabled(),'2');
    }

    @Test
    public void SignUpTest1(){

        UserVO user = new UserVO();

        user.setEnabled(1);
        user.setEmail("pla_master26@naver.com");
        user.setEmlAuthTkn("KER123Q");
        user.setPwd("1234QQW12!");
        user.setPnt(3000); //포인트도 회원가입시에는 안들어감!
        user.setMemo("테스트로 추가된 사용자 SM"); //메모는 회원가입시 집어넣는게 아니라서 쿼리에 없음??
        user.setName("테둥이");
        user.setRoleCode("002");
        user.setTelNo("010-3333-1234");

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        String encodedPwd = passwordEncoder.encode(user.getPwd());

        user.setPwd(encodedPwd);

        int register = signUpService.register(user);

        assertEquals(register,1);
    }

    @Test
    public void SignUpTest2(){

        String email = "pla_master26@naver.com";

        UserVO user = signUpService.getByEmail(email);

        assertEquals(user.getPnt(),0);
        assertEquals(user.getRoleCode(),"002");
        assertEquals(user.getName(),"테둥이");
    }

    @Test
    public void SignUpTest3(){

        UserVO user = new UserVO();

        int register = signUpService.register(user);

        assertEquals(register, 0);

    }


}
