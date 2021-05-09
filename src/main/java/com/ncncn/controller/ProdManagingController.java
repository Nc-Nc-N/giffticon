package com.ncncn.controller;

import java.io.File;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.domain.request.ProdRegisterDTO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;
import com.ncncn.service.ProductService;
import lombok.extern.log4j.Log4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
@Log4j
public class ProdManagingController {

	private ProductService productService;

	private CategoryService categoryService;

	private BrandService brandService;

	public ProdManagingController(ProductService productService, CategoryService categoryService, BrandService brandService) {
		this.productService = productService;
		this.categoryService = categoryService;
		this.brandService = brandService;
	}

	@GetMapping("/product/prodList")
	public void getProdList(ProdCriteria cri, Model model) {
		try {
			List<AdminProdListVO> prodList = productService.getAllProduct(cri);
			int total = productService.countAllProd(cri);
			model.addAttribute("prodList", prodList);
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		} catch (Exception e) {
			model.addAttribute("error", "해당 정보를 조회하는데 문제가 발생했습니다.");
		}
	}

	@GetMapping(value = "/product/cateList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CategoryVO>> getCateList() {
		List<CategoryVO> cateList;
		try {
			cateList = categoryService.getCategoryList();
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(cateList, HttpStatus.OK);
	}

	@GetMapping(value = "/product/category/{cateCode}/brdList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BrandVO>> getBrdList(@PathVariable("cateCode") String cateCode) {
		List<BrandVO> brdList;
		try {
			brdList = brandService.getBrdList(cateCode);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(brdList, HttpStatus.OK);
	}

	@GetMapping(value = "/product/{prodCode}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ProductVO> getProd(@PathVariable("prodCode") String prodCode) {
		ProductVO productVO;
		try {
			productVO = productService.getProdByCode(prodCode);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(productVO, HttpStatus.OK);
	}

	@PostMapping(value = "/product/register")
	public String register(ProdRegisterDTO product, @RequestParam("prodImg") MultipartFile[] files, ProdCriteria cri, RedirectAttributes rattr) {
		rattr.addFlashAttribute("pageNum", cri.getPageNum());
		rattr.addFlashAttribute("amount", cri.getAmount());
		rattr.addFlashAttribute("type", cri.getType());
		rattr.addFlashAttribute("keyword", cri.getKeyword());

		String cateCode = product.getBrdCode().substring(0, 2);
		String uploadFolder = "C:/Users/lwiii/Desktop/Projects/giffticon/src/main/webapp";
		String prodFolder = "/resources/img/product/" + cateCode + "/" + product.getBrdCode() + "/";
		String fileName = files[0].getOriginalFilename();
		String fileExtension = "." + FilenameUtils.getExtension(fileName);

		product.setImgPath(prodFolder);
		product.setFileExtension(fileExtension);
		String code = "";
		try {
			code = productService.register(product);

			File upload = new File(uploadFolder, prodFolder);
			if (!upload.exists()) {
				upload.mkdirs();
			}
			File saveFile = new File(uploadFolder + prodFolder, code + fileExtension);
			files[0].transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
			rattr.addAttribute("error", "상품을 등록하는데 실패했습니다. 새로고침 후 다시 시도해주세요.\n문제가 반복되면 담당자에게 문의해주세요.");
		}

		return "redirect:/admin/product/prodList";
	}

	@PostMapping(value = "/product/modify")
	public String modify(ProdRegisterDTO product, @RequestParam("prodImg") MultipartFile[] files, ProdCriteria cri, RedirectAttributes rattr) {
		rattr.addFlashAttribute("pageNum", cri.getPageNum());
		rattr.addFlashAttribute("amount", cri.getAmount());
		rattr.addFlashAttribute("type", cri.getType());
		rattr.addFlashAttribute("keyword", cri.getKeyword());

		String cateCode = product.getBrdCode().substring(0, 2);
		String uploadFolder = "C:/Users/lwiii/Desktop/Projects/giffticon/src/main/webapp";
		String imgPath = "/resources/img/product/" + cateCode + "/" + product.getBrdCode() + "/";
		String fileName = files[0].getOriginalFilename();
		String fileExtension = "." + FilenameUtils.getExtension(fileName);

		try {
			// 이미지 파일을 첨부하지 않은 경우
			if (files[0].isEmpty()) {
				productService.modifyProduct(product);
			} else {
				// 이미지 파일을 첨부한 경우
				File oldFile = new File(uploadFolder + product.getImgPath());
				if (oldFile.exists()) {
					oldFile.delete();
				}

				product.setImgPath(imgPath);
				product.setFileExtension(fileExtension);

				productService.modifyProductWithImagePath(product);

				File saveFile = new File(uploadFolder + imgPath + product.getCode() + fileExtension);
				files[0].transferTo(saveFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
			rattr.addAttribute("error", "상품 수정에 실패했습니다. 새로고침 후 다시 시도해주세요.\n문제가 반복되면 담당자에게 문의해주세요.");
		}

		return "redirect:/admin/product/prodList";
	}
}
