package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;

	@GetMapping(value = "manage/board")
	public ModelAndView board(ModelAndView mav) {
		mav.setViewName("main/manage/board");
		return mav;
	}
}