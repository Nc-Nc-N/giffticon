package com.ncncn.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class MainController {

	@GetMapping("/home")
	public void main(){

	}
}
