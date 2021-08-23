package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.service.MainService;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
	private final MainService mainService;
	private final String redirectPath;

	@Autowired
	public MainController(MainService mainService, @Value("${server.servlet.context-path}") String contextPath) {
		this.mainService = mainService;
		redirectPath = contextPath + "/main";
	}

	@GetMapping(value = "/")
	public void main(HttpServletResponse httpServletResponse) throws IOException {
		httpServletResponse.sendRedirect(redirectPath);
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView mainView(ModelAndView mv) {
		mv.addObject("topicBestList", mainService.topicBestList());
		mv.addObject("topicSubList", mainService.topicSubList());
		mv.setViewName("main/main");

		return mv;
	}

	@GetMapping(value = "directory")
	public ModelAndView directory(
		@RequestParam(defaultValue = "ア") StringBuilder searchKeyword, @RequestParam(defaultValue = "1") int page
	) {
		DirectorySearchDto directorySearchDto = mainService.getDirectorySearchDto(searchKeyword);
		PageNavigator navi = mainService.getDirectoryNavigator(page, directorySearchDto);
		List<DirectoryCompanyVO> companyList =
			mainService.getDirectoryCompanyList(navi.getCurrentPage(), directorySearchDto);

		ModelAndView modelAndView = new ModelAndView("main/directory");
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyList", companyList);

		return modelAndView;
	}

	@ResponseBody
	@GetMapping(value = "directory", params = "ajax")
	public Map<String, Object> getDirectory(
		@RequestParam(defaultValue = "ア") StringBuilder searchKeyword, @RequestParam(defaultValue = "1") int page
	) {
		DirectorySearchDto directorySearchDto = mainService.getDirectorySearchDto(searchKeyword);
		PageNavigator navi = mainService.getDirectoryNavigator(page, directorySearchDto);
		List<DirectoryCompanyVO> companyList =
			mainService.getDirectoryCompanyList(navi.getCurrentPage(), directorySearchDto);

		Map<String, Object> directory = new HashMap<>(2);
		directory.put("navi", navi);
		directory.put("companyList", companyList);

		return directory;
	}
}