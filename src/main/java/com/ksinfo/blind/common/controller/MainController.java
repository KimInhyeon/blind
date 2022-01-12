package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.service.MainService;
import com.ksinfo.blind.common.vo.BestMainPostVO;
import com.ksinfo.blind.common.vo.SubMainPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public final class MainController {
	private final MainService mainService;

	@Autowired
	public MainController(MainService mainService) {
		this.mainService = mainService;
	}

	@GetMapping({"/", "main"})
	public ModelAndView mainView() {
		List<BestMainPostVO> bestMainPostList = mainService.getBestMainPostList();
		List<SubMainPostVO> subMainPostList = mainService.getSubMainPostList();

		ModelAndView modelAndView = new ModelAndView("main/common/main");
		modelAndView.addObject("title", "KSINFOSYS BLIND");
		modelAndView.addObject("bestMainPostList", bestMainPostList);
		modelAndView.addObject("subMainPostList", subMainPostList);

		return modelAndView;
	}

	@GetMapping("board")
	public List<BoardVO> getBoardList() {
		System.out.println("connect by androidTest"); //androidがintelliJに接続したことを教えるlog役割のテキスト。
		return mainService.getBoardList();
	}
}