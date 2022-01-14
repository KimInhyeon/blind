package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.dto.SearchPostDto;
import com.ksinfo.blind.common.service.SearchService;
import com.ksinfo.blind.common.vo.SearchBoardVO;
import com.ksinfo.blind.common.vo.SearchCompanyVO;
import com.ksinfo.blind.common.vo.SearchPostVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("search")
public final class SearchController {
//	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	private final SearchService searchService;

	@Autowired
	public SearchController(SearchService searchService) {
		this.searchService = searchService;
	}

	@GetMapping
	public ModelAndView search(
		@AuthenticationPrincipal Account account, String searchKeyword, String sort,
		@RequestParam(defaultValue = "0") long boardId, @RequestParam(defaultValue = "0") long postId
	) {
		long userId = account == null ? 0L : account.getUserId();
		SearchPostDto search = new SearchPostDto(userId, boardId, postId, searchKeyword, sort);
		List<SearchPostVO> postList = searchService.getPostList(search);

		if (searchKeyword == null) {
			List<BoardVO> boardList = searchService.getBoardSliderList();

			ModelAndView modelAndView = new ModelAndView("main/board/board");
			modelAndView.addObject("postList", postList);
			modelAndView.addObject("boardList", boardList);
			modelAndView.addObject("boardId", boardId);
			for (int i = 0, size = boardList.size(); i < size; ++i) {
				BoardVO board = boardList.get(i);
				if (boardId == board.getBoardId()) {
					modelAndView.addObject("title", board.getBoardTopicName());
					modelAndView.addObject("slideIndex", i);
					break;
				}
			}

			return modelAndView;
		}

		List<SearchCompanyVO> companyList = searchService.getSearchCompanyList(searchKeyword);
		List<SearchBoardVO> boardList = searchService.getSearchBoardList(searchKeyword);

		ModelAndView modelAndView = new ModelAndView("main/common/search");
		modelAndView.addObject("title", searchKeyword);
//		modelAndView.addObject("companyList", companyList); // search.jspでリストを出力するように変更が必要
		if (!companyList.isEmpty()) {
			modelAndView.addObject("company", companyList.get(0)); // search.jspでリストを出力するように変更が必要
		}
		modelAndView.addObject("boardList", boardList);
		modelAndView.addObject("postList", postList);

		return modelAndView;
	}

	@GetMapping(params = "ajax=true")
	public List<SearchPostVO> getSearchPostList(
		@AuthenticationPrincipal Account account, String searchKeyword, String sort,
		@RequestParam(defaultValue = "0") long boardId, @RequestParam(defaultValue = "0") long postId
	) {
		long userId = account == null ? 0L : account.getUserId();
		SearchPostDto search = new SearchPostDto(userId, boardId, postId, searchKeyword, sort);

		return searchService.getPostList(search);
	}

	@GetMapping("board")
	public List<BoardVO> getBoardSliderList() {
		return searchService.getBoardSliderList();
	}
}