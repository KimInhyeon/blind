package com.ksinfo.blind.member.controller;

import com.ksinfo.blind.member.dto.BookmarkDto;
import com.ksinfo.blind.member.service.BookmarkService;
import com.ksinfo.blind.member.vo.BookmarkPostVO;
import com.ksinfo.blind.member.vo.BookmarkVO;
import com.ksinfo.blind.member.vo.MyPostVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("bookmark")
public final class BookmarkController {
	private final BookmarkService bookmarkService;

	@Autowired
	public BookmarkController(BookmarkService bookmarkService) {
		this.bookmarkService = bookmarkService;
	}

	@GetMapping
	public ModelAndView myBookmarkView(@AuthenticationPrincipal Account account) {
		List<BookmarkPostVO> postList = bookmarkService.getMyBookmarkList(account.getUserId(), 0);

		ModelAndView modelAndView = new ModelAndView("main/member/myBookmark");
		modelAndView.addObject("title", "ブックマーク");
		modelAndView.addObject("postList", postList);

		return modelAndView;
	}

	@PostMapping
	public boolean bookmark(@AuthenticationPrincipal Account account, @RequestBody long postId) {
		BookmarkDto bookmarkDto = new BookmarkDto(account.getUserId(), postId);

		// true: ブックマーク追加、false: ブックマーク削除
		return bookmarkService.bookmark(bookmarkDto);
	}

	@GetMapping(value = "member/post", params = "offset")
	public List<BookmarkPostVO> getMyPostList(@AuthenticationPrincipal Account account, @RequestParam int offset) {

		return bookmarkService.getMyBookmarkList(account.getUserId(), offset);
	}

	/*
	@GetMapping(value = "getMyPostListAndroid", params = "offset")
	public List<BookmarkPostVO> getMyPostList(Long userId, @RequestParam int offset) {
		System.out.println("Android Access getMyPostList");
		System.out.println("getMyPostList-userId : "+userId);
		System.out.println("getMyPostList-offset : "+offset);
		return bookmarkService.getMyBookmarkList(userId, offset);
	}
	*/

	@GetMapping(value = "getMyPostListAndroid")
	public List<BookmarkPostVO> getMyPostList(Long userId) {
		System.out.println("Android Access getMyPostList");
		System.out.println("getMyPostList-userId : "+userId);
		return bookmarkService.getMyBookmarkList(userId, 0);
	}
}