package com.ncncn.controller;

import com.ncncn.domain.WishListVO;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@Log4j
@RequestMapping("/wishList/*")
@AllArgsConstructor
public class WishListController {

    private WishListService service;

    // 관심상품에 추가하기
    @PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody WishListVO wish){

        log.info("WishListVO: "+wish);
        int insertCount = service.insertWish(wish);

        log.info("INSERT COUNT: "+insertCount);

        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // 관심상품에서 삭제하기
    @PostMapping(value = "/remove", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> remove(@RequestBody WishListVO wish){

        log.info("WishListVO: "+wish);
        int deleteCount = service.deleteWish(wish);

        log.info("DELETE COUNT: "+deleteCount);

        return deleteCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}