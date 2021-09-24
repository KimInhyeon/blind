package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.service.DirectoryService;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("directory")
public final class DirectoryController {
	private final DirectoryService directoryService;

	@Autowired
	public DirectoryController(DirectoryService directoryService) {
		this.directoryService = directoryService;
	}

	@GetMapping
	public ModelAndView directory(
		@RequestParam(defaultValue = "ア") StringBuilder searchKeyword, @RequestParam(defaultValue = "1") int page
	) {
		DirectorySearchDto directorySearchDto = directoryService.getDirectorySearchDto(searchKeyword);
		PageNavigator navi = directoryService.getDirectoryNavigator(page, directorySearchDto);
		List<DirectoryCompanyVO> companyList =
			directoryService.getDirectoryCompanyList(navi.getCurrentPage(), directorySearchDto);

		ModelAndView modelAndView = new ModelAndView("main/common/directory");
		modelAndView.addObject("title", "ディレクトリ");
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyList", companyList);

		return modelAndView;
	}

	@GetMapping(params = "ajax=true")
	public Map<String, Object> getDirectory(
		@RequestParam(defaultValue = "ア") StringBuilder searchKeyword, @RequestParam(defaultValue = "1") int page
	) {
		DirectorySearchDto directorySearchDto = directoryService.getDirectorySearchDto(searchKeyword);
		PageNavigator navi = directoryService.getDirectoryNavigator(page, directorySearchDto);
		List<DirectoryCompanyVO> companyList =
			directoryService.getDirectoryCompanyList(navi.getCurrentPage(), directorySearchDto);

		Map<String, Object> directory = new HashMap<>(2);
		directory.put("navi", navi);
		directory.put("companyList", companyList);

		return directory;
	}
}