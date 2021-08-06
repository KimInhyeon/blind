package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.service.BoardService;
import com.ksinfo.blind.manage.vo.BoardVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class BoardController {
	private final BoardService boardService;

	@Autowired
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}

	@GetMapping(value = "manage/board")
	public ModelAndView board(
		@RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
		@RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
	) {
		List<BoardVO> boardList = boardService.getBoardList(closedFlag, anonymousFlag);

		ModelAndView modelAndView = new ModelAndView("main/manage/board");
		modelAndView.addObject("boardList", boardList);
		if (closedFlag == '0' && anonymousFlag == '2') {
			modelAndView.addObject("lastOrder", boardList.size());
		} else {
			modelAndView.addObject("lastOrder", boardService.getLastOrder());
		}

		return modelAndView;
	}

	@GetMapping(value = "manage/board", params = "ajax=true")
	public List<BoardVO> getBoardList(
		@RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
		@RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
	) {
		return boardService.getBoardList(closedFlag, anonymousFlag);
	}

	@PostMapping(value = "manage/board")
	public long createBoard(@RequestBody BoardCreateDto board, @AuthenticationPrincipal Account account) {
		board.setUserId(account.getUserId());
		return boardService.createBoard(board);
	}

	@PatchMapping(value = "manage/board")
	public int updateBoard(@RequestBody BoardUpdateDto board, @AuthenticationPrincipal Account account) {
		board.setUserId(account.getUserId());
		return boardService.updateBoard(board);
	}
}