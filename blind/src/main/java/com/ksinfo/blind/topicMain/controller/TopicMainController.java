package com.ksinfo.blind.topicMain.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.service.PostService;
import com.ksinfo.blind.topicMain.service.TopicMainService;

@Controller
public class TopicMainController {

	@Autowired
	TopicMainService topicMainService;

	@Autowired
	PostService postService;

	@RequestMapping(value = "topicMain", method = RequestMethod.GET)
	public ModelAndView topicMain(HttpSession session, ModelAndView mav) {
		mav.addObject("topicMainMessage", topicMainService.getTopicMainList());
		mav.setViewName("main/topicMain/topicMain");

		return mav;
	}

	@RequestMapping(value = "searchBoardName", method = RequestMethod.GET)
	public ModelAndView searchBoardName(String searchKeyword, ModelAndView mav) {
		List<PostDto> searchResultPosts = postService.getPostListBySearchKeyword(searchKeyword);

		mav.addObject("searchResultPosts", searchResultPosts);
		mav.addObject("topicMainMessage", topicMainService.getTopicMainList());
		mav.setViewName("main/topicMain/topicMain");

		return mav;
	}
}