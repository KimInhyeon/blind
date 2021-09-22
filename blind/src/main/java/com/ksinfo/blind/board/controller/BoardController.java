package com.ksinfo.blind.board.controller;

import com.ksinfo.blind.board.dto.SearchBoardPostDto;
import com.ksinfo.blind.board.service.BoardService;
import com.ksinfo.blind.board.vo.BoardPostVO;
import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("board")
public final class BoardController {
	private final BoardService boardService;

	@Autowired
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}

	@GetMapping
	public List<BoardVO> getBoardList() {
		return boardService.getBoardList();
	}

	@GetMapping("{boardId}")
	public ModelAndView board(@AuthenticationPrincipal Account account, @PathVariable("boardId") long boardId) {
		List<BoardVO> boardList = boardService.getSearchBoardList();
		long userId = account == null ? 0L : account.getUserId();
		List<BoardPostVO> postList = boardService.getBoardPostList(new SearchBoardPostDto(userId, boardId, 0L));

		ModelAndView modelAndView = new ModelAndView("main/board/board");
		modelAndView.addObject("boardId", boardId);
		modelAndView.addObject("boardList", boardList);
		modelAndView.addObject("postList", postList);
		for (int i = 0, topicListSize = boardList.size(); i < topicListSize; ++i) {
			BoardVO board = boardList.get(i);
			if (boardId == board.getBoardId()) {
				modelAndView.addObject("title", board.getBoardTopicName());
				modelAndView.addObject("slideIndex", i);
				break;
			}
		}

		return modelAndView;
	}

	@GetMapping(value = "{boardId}", params = "postId")
	public List<BoardPostVO> getBoardPostList(
		@AuthenticationPrincipal Account account,
		@PathVariable("boardId") long boardId, @RequestParam("postId") long postId
	) {
		long userId = account == null ? 0L : account.getUserId();

		return boardService.getBoardPostList(new SearchBoardPostDto(userId, boardId, postId));
	}

	// 게시물 추천
//	@RequestMapping(value = "/postRecommendInsert", method = RequestMethod.POST)
//	public List<PostRecommendDto> postRecommendInsert(@AuthenticationPrincipal Account account, PostDetailDto postDetailDto) {
//		postDetailDto.setUserId(account.getUserId());
////		postService.postRecommendInsert(postDetailDto);
////		List<PostRecommendDto> postRecommend = postService.postRecommend(postDetailDto.getPostId());
//
////		return postRecommend;
//		return null;
//	}
}