package com.ncncn.controller;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration

@ContextConfiguration({"file:src/main/webapp/WEB-INF/applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
@Log4j
public class NoticeControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup(){
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testList() throws Exception{

		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/cs/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}

	@Test
	public void testListPaging() throws Exception{

		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("cs/adminNotice")
				.param("pageNum", "2")
				.param("amount", "20"))
				.andReturn().getModelAndView().getModelMap());
	}


}
