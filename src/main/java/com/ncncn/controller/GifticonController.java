package com.ncncn.controller;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.UserVO;
import com.ncncn.service.GifticonService;
import com.ncncn.service.UserService;
import com.ncncn.util.UserAuthCheckUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/gifticon")
@AllArgsConstructor
public class GifticonController {

    GifticonService gifticonService;
    UserService userService;

    @PostMapping("/stus005")
    public String gftDealCmpl(HttpServletRequest request, int gftId, Model model) {

        //기프티콘 상태 구매확정대기 -> 구매 확정 변경
        gifticonService.gftDealCmpl(gftId);

        //구매상세페이지에서 구매확정한 경우 구매상세로 다시 보냄
        if (request.getHeader("referer").contains("/dealDetail")) {
            model.addAttribute("gftId", gftId);
            return "redirect:/user/mypage/dealDetail";
        }

        //구매리스트에서 구매확정한 경우 구매리스트로 다시 보냄
        return "redirect:/user/mypage/deal";
    }

    @PostMapping("/delGft")
    public String deleteGifticon(int gftId) {
        //성공실패 메세지
        try {
            gifticonService.deleteGifticon(gftId);
        }catch(Exception e){
            log.info("기프티콘 삭제 오류 발생");
        }

        return "redirect:/user/mypage/sells";
    }

    @RequestMapping(method = {RequestMethod.POST}, //기프티콘 가격 수정 컨트롤러
            value = "/updateGft",
            consumes = "application/json",
            produces = "application/text; charset=utf-8")
    public ResponseEntity<String> updateGifticon(@RequestBody PrcUpdateVO prcUpdate, HttpServletRequest request) {

        int userId = (int) request.getSession().getAttribute("userId");

        //세션에 담긴 user의 정보 불러오기
        UserVO user = userService.readbyId(userId);

        // 제출한 비밀번호와 db유저비밀번호를 비교 후 true 이면 가격 수정 실행
        if (UserAuthCheckUtils.userAuthCheck(prcUpdate.getEmail(), prcUpdate.getPassword(), user)) {

            int isUpdated = gifticonService.updateGftPrc(prcUpdate);

            //가격 수정 성공한 경우 success
            if (isUpdated == 1) {
                return new ResponseEntity<>(HttpStatus.OK);
            //가격 수정 실패한 경우 serverError
            } else {
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        //비밀번호 일치하지 않는 경우 serverError
        } else {
            log.info("비밀번호가 일치하지 않습니다.");
            return new ResponseEntity<>(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @GetMapping(value = "/{prdCode}")
    public ResponseEntity<String> countOnSelling(@PathVariable("prdCode") String prdCode) {

        try {

            //해당 상품의 판매중인 기프티콘 수량 체크
            int count = gifticonService.countOnselling(prdCode);
            //판매중인 기프티콘 수량이 0 이 아니면 status OK 반환 없으면 error
            return count > 0 ? new ResponseEntity<>(HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

        } catch (Exception e) {

            //서버 에러 시 error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

        }

    }
}
