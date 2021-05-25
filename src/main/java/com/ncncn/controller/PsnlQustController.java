package com.ncncn.controller;

import javax.servlet.http.HttpServletRequest;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.domain.request.AttachFileDTO;
import com.ncncn.service.PsnlQustService;
import lombok.extern.log4j.Log4j;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@Log4j
public class PsnlQustController {

	private PsnlQustService service;
	private String psnlqustpath;

	public PsnlQustController(
			@Value("#{psnlqustpath['path']}") String psnlqustpath,
			PsnlQustService service
	){
		this.psnlqustpath = psnlqustpath;
		this.service = service;
	}


	// 사용자

	@GetMapping("/user/mypage/psnlQustBoard")
	public String psnlQustBoard(HttpServletRequest request, CsCriteria cri, Model model) {

		log.info(cri.getType());
		log.info(cri.getTypeArr());

		int userId = (int) request.getSession().getAttribute("userId");

		try {

			//userId를 추가해 user에 따라 자신의 1:1 문의만 list에 담아 보여주게 함.
			model.addAttribute("list", service.getListPsnlQust(cri, userId));

			log.info("userId : " + userId);

			int total = service.getTotalPsnlQust(cri, userId);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));


		}catch (Exception e){

			e.printStackTrace();

			model.addAttribute("error" , e.getMessage());

		}

		return "/user/cs/psnlQustBoard";

	}

	//사용자 1:1문의 등록 page 이동
	@GetMapping("/user/mypage/psnlQustBoard/register")
	public String registerPsnlQust() {

		return "/user/cs/registerPsnlQust";
	}

	//1:1문의 파일 업로드 ajax
	@PostMapping(value = "/psnl/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){

		log.info("upload ajax post.......");

		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = psnlqustpath;

		String uploadFolderPath = getFolder();

		//make folder
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false){
			try {
				uploadPath.mkdirs();
			}catch (Exception e){
				e.printStackTrace();
			}
		}

		for (MultipartFile multipartFile : uploadFile){

			AttachFileDTO attachDTO = new AttachFileDTO();

			log.info("---------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);

			//  uuid 생성
			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try{
				File saveFile = new File(uploadPath, uploadFileName);
				//서버에 파일 저장
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				attachDTO.setImage(true);

				list.add(attachDTO);

			}catch (Exception e){
				e.printStackTrace();
			}

		}//end for

		return new ResponseEntity<>(list,HttpStatus.OK);

	}


	//사용자 1:1문의 등록
	@PostMapping(value = "/user/mypage/psnlQustBoard/register", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public void register(@RequestBody CsPsnlQustVO qna){
		try{
			service.register(qna);
			log.info("register qna success");
		}catch (Exception e){
			e.printStackTrace();
		}
	}



	//사용자 1:1문의 수정
	@PostMapping("/user/mypage/psnlQustBoard/modify")
	public String modifyUser(HttpServletRequest request, CsPsnlQustVO qna, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {

		log.info("modify: " + qna);

		int userId = (int) request.getSession().getAttribute("userId");

		try {
			service.modifyFromUser(qna);

			if (service.modifyFromUser(qna)) {
				rttr.addFlashAttribute("result", "success");		//modify 성공 알람.
			}

			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error", e.getMessage());
		}


		return "redirect:/user/mypage/psnlQustBoard";
	}

	//사용자 1:1문의 삭제
	@PostMapping("/user/mypage/psnlQustBoard/remove")
	public String removeUser(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {


		log.info("remove...." + id);


		try {

			int userId = (int) request.getSession().getAttribute("userId");

			service.remove(id);

			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error",HttpStatus.INTERNAL_SERVER_ERROR);
		}


		return "redirect:/user/mypage/psnlQustBoard";
	}





	// 관리자

	@GetMapping("/admin/adminPsnlQust")
	public String adminFaq(HttpServletRequest request, CsCriteria cri, Model model) {

		log.info("list: " + cri);

		try {
			//userId가 관리자라면 list를 출력할 때 모든 user의 1:1문의를 list에 출력.
			int userId = (int) request.getSession().getAttribute("userId");
			model.addAttribute("userId", userId);
			model.addAttribute("list", service.getList(cri));

			int total = service.getTotal(cri);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));

		}catch (Exception e){
			e.printStackTrace();
			model.addAttribute("error" , e.getMessage());
		}

		return "/admin/cs/adminPsnlQust";

	}

	//관리자 1:1문의 수정(답변 달기)
	@PostMapping("/admin/adminPsnlQust/modify")
	public String modify(HttpServletRequest request, CsPsnlQustVO qna, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {

		log.info("modify: " + qna);

		int userId = (int) request.getSession().getAttribute("userId");

		try {

			service.modify(qna);

			if (service.modify(qna)) {
				rttr.addFlashAttribute("result", "success");		//답변 및 수정 성공 알람.
			}
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error", e.getMessage());
		}


		return "redirect:/admin/adminPsnlQust";
	}

	//관리자 1:1문의 삭제
	@PostMapping("/admin/adminPsnlQust/remove")
	public String remove(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {


		log.info("remove...." + id);

		int userId = (int) request.getSession().getAttribute("userId");

		try {
			service.remove(id);
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error",HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminPsnlQust";
	}


	//Modal에 데이터 받기위해 ajax를 사용하여 객체 전달.
	@GetMapping(value = "/psnl", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsPsnlQustVO> getPsnlQust(@RequestParam("id") int id) {

		try {

			CsPsnlQustVO qnaVO = service.get(id);

			return new ResponseEntity<>(qnaVO, HttpStatus.OK);

		}catch (Exception e){

			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

		}

	}


	//날짜별 업로드 폴더 생성
	private  String getFolder(){

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}

	//업로드된 파일이 이미지 타입인지 검사
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

}
