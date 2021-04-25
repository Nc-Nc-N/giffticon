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

    @GetMapping("/stus005")
    public String gftDealCmpl(HttpServletRequest request, int gftId, MyPageCriteria cri, Model model) {

        gifticonService.gftDealCmpl(gftId);

        //return redirect 시에는 페이지네이션 유지 불가 (forward 써야 하는데 이후 error catch 못함)
        //model.addAttribute("cri", cri);

        if (request.getHeader("referer").contains("/dealDetail")) { //구매상세페이지에서 구매확정한 경우 구매상세로 다시 보냄

            model.addAttribute("gftId", gftId);
            return "redirect:/user/mypage/dealDetail";
        }

        //구매리스트에서 구매확정한 경우 구매리스트로 다시 보냄
        return "redirect:/user/mypage/deal";
    }

    @GetMapping("/delGft")
    public String deleteGifticon(int gftId, MyPageCriteria cri, Model model) {

        //return redirect 시에는 페이지네이션 유지 불가 (forward 써야 하는데 이후 error catch 못함)
        //model.addAttribute("cri", cri);

        try {
            gifticonService.deleteGifticon(gftId);

        } catch (Exception e) {
            log.info("기프티콘 삭제에 실패했습니다.");
        }
        return "redirect:/user/mypage/sells";
    }

    @RequestMapping(method = {RequestMethod.POST}, //기프티콘 가격 수정 컨트롤러
            value = "/updateGft",
            consumes = "application/json",
            produces = "application/text; charset=utf-8")
    public ResponseEntity<String> updateGifticon(@RequestBody PrcUpdateVO prcUpdate, HttpServletRequest request) {

        int userId = (int) request.getSession().getAttribute("userId");
        UserVO user = userService.readbyId(userId);

        String msg = "";

        //비밀번호 체크 후 true 이면 가격 수정 실행
        if (UserAuthCheckUtils.userAuthCheck(prcUpdate.getEmail(), prcUpdate.getPassword(), user)) {

            int isUpdated = gifticonService.updateGftPrc(prcUpdate);

            if (isUpdated == 1) { //가격 수정 성공한 경우 success

                return new ResponseEntity<>(HttpStatus.OK);
            } else { //가격 수정 실패한 경우 serverError

                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else { //비밀번호 일치하지 않는 경우 serverError

            log.info("비밀번호가 일치하지 않습니다.");
            return new ResponseEntity<>(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @GetMapping(value = "/{prdCode}")
    public ResponseEntity<String> countOnSelling(@PathVariable("prdCode") String prdCode) {

        try {

            int count = gifticonService.countOnselling(prdCode);
            //기프티콘 수량이 0 이 아니면 status OK 반환 없으면 error
            return count > 0 ? new ResponseEntity<>(HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            
            //수량 체크 실패 시 error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
