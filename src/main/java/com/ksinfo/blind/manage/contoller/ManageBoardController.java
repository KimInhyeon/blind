package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.service.ManageBoardService;
import com.ksinfo.blind.manage.vo.ManageBoardVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("manage/board")
public final class ManageBoardController {
	private final ManageBoardService manageBoardService;

	@Autowired
	public ManageBoardController(ManageBoardService manageBoardService) {
		this.manageBoardService = manageBoardService;
	}

	@GetMapping
	public ModelAndView manageBoard(
		@RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
		@RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
	) {
		List<ManageBoardVO> boardList = manageBoardService.getBoardList(closedFlag, anonymousFlag);

		ModelAndView modelAndView = new ModelAndView("main/manage/manageBoard");
		modelAndView.addObject("title", "トピック管理");
		modelAndView.addObject("boardList", boardList);
		if (closedFlag == '0' && anonymousFlag == '2') {
			modelAndView.addObject("lastOrder", boardList.size());
		} else {
			modelAndView.addObject("lastOrder", manageBoardService.getLastOrder());
		}

		return modelAndView;
	}

	@GetMapping(params = "ajax=true")
	public List<ManageBoardVO> getBoardList(
		@RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
		@RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
	) {
		return manageBoardService.getBoardList(closedFlag, anonymousFlag);
	}

	@PostMapping
	public long createBoard(@RequestBody BoardCreateDto board, @AuthenticationPrincipal Account account) {
		board.setUserId(account.getUserId());
		return manageBoardService.createBoard(board);
	}

	@PatchMapping
	public int updateBoard(@RequestBody BoardUpdateDto board, @AuthenticationPrincipal Account account) {
		board.setUserId(account.getUserId());
		return manageBoardService.updateBoard(board);
	}
}