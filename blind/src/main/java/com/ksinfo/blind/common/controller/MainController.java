package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.service.MainService;
import com.ksinfo.blind.common.vo.BestMainPostVO;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.common.vo.SubMainPostVO;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public final class MainController {
	private final MainService mainService;
	private final String mainPath;
	private final String manageCompanyPath;

	@Autowired
	public MainController(MainService mainService, @Value("${server.servlet.context-path}") String contextPath) {
		this.mainService = mainService;
		mainPath = contextPath + "/main";
		manageCompanyPath = contextPath + "/manage/company";
	}

	@GetMapping(value = "/")
	public void main(HttpServletResponse httpServletResponse) throws IOException {
		httpServletResponse.sendRedirect(mainPath);
	}

	@GetMapping(value = "manage")
	public void company(HttpServletResponse httpServletResponse) throws IOException {
		httpServletResponse.sendRedirect(manageCompanyPath);
	}

	@GetMapping(value = "main")
	public ModelAndView mainView() {
		List<BestMainPostVO> bestMainPostList = mainService.getBestMainPostList();
		List<SubMainPostVO> subMainPostList = mainService.getSubMainPostList();

		ModelAndView modelAndView = new ModelAndView("main/main");
		modelAndView.addObject("bestMainPostList", bestMainPostList);
		modelAndView.addObject("subMainPostList", subMainPostList);

		return modelAndView;
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

	@GetMapping(value = "directory", params = "ajax=true")
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