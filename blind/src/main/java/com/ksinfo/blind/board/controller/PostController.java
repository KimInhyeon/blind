package com.ksinfo.blind.board.controller;

import com.ksinfo.blind.board.dto.PostDto;
import com.ksinfo.blind.board.dto.PostRequestDto;
import com.ksinfo.blind.board.service.PostService;
import com.ksinfo.blind.board.service.ReplyService;
import com.ksinfo.blind.board.vo.PostVO;
import com.ksinfo.blind.board.vo.ReplyVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.StringTokenizer;

@RestController
@RequestMapping("post")
public final class PostController {
	private final PostService postService;
	private final ReplyService replyService;

	@Autowired
	public PostController(PostService postService, ReplyService replyService) {
		this.postService = postService;
		this.replyService = replyService;
	}

	@PostMapping
	public long writePost(@AuthenticationPrincipal Account account, @RequestBody PostDto postDto) {
		postDto.setUserId(account.getUserId());
		return postService.writePost(postDto);
	}

	@GetMapping("{postId}")
	public ModelAndView post(
		@AuthenticationPrincipal Account account, @PathVariable long postId,
		@CookieValue(name = "readPost", required = false) Cookie cookie, HttpServletResponse httpServletResponse
	) {
		if (cookie == null) {
			cookie = new Cookie("readPost", Long.toString(postId));
			httpServletResponse.addCookie(cookie);
			postService.readPost(postId);
		} else {
			String history = cookie.getValue();
			StringTokenizer st = new StringTokenizer(history, "\\|", false);
			boolean isReadPost;
			do {
				isReadPost = postId == Long.parseLong(st.nextToken());
			} while (!isReadPost && st.hasMoreTokens());
			if (!isReadPost) {
				cookie.setValue(history + '|' + postId);
				httpServletResponse.addCookie(cookie);
				postService.readPost(postId);
			}
		}
		PostRequestDto postRequest = new PostRequestDto(account == null ? 0L : account.getUserId(), postId);
		PostVO post = postService.getPost(postRequest);
		List<ReplyVO> replyList = replyService.getReplyList(postRequest);

		ModelAndView modelAndView = new ModelAndView("main/board/post");
		modelAndView.addObject("post", post);
		modelAndView.addObject("replyList", replyList);

		return modelAndView;
	}
}