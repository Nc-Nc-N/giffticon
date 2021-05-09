package com.ncncn.controller;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.service.BrandService;
import com.ncncn.service.GifticonService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user/map/")
@AllArgsConstructor
@Log4j
public class MapController {

    BrandService brandService;

    GifticonService gifticonService;

    @GetMapping(value="/getBrdList/{cateCode}")
    public ResponseEntity<Map<String,String>> getBrdList(@PathVariable String cateCode){

        log.info("get CateCode : " + cateCode);
        try {

            List<BrandVO> brdList = brandService.getBrdList(cateCode);

            Map<String, String> brdMap = new HashMap<>();

            for(int i=0; i<brdList.size(); i++){
                brdMap.put(brdList.get(i).getCode(),brdList.get(i).getName());
            }

            log.info("brdMap :" + brdMap);

            return new ResponseEntity<Map<String,String>>(brdMap, HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping(value="/getMainGfts/{brdName}")
    public ResponseEntity<List<ProdListVO>> getMainGfts(@PathVariable String brdName){
        log.info("brdName :" + brdName);
        try{
            List<ProdListVO> mainGftList = gifticonService.getMainGftByBrandName(brdName);

            return new ResponseEntity<List<ProdListVO>>(mainGftList, HttpStatus.OK);
        }catch (Exception e){

            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
