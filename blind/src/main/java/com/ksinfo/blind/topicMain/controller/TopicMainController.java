package com.ksinfo.blind.topicMain.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.dto.TopicMainDto;
import com.ksinfo.blind.topicMain.service.PostService;
import com.ksinfo.blind.topicMain.service.TopicMainService;

@Controller
public class TopicMainController {

	@Autowired
	TopicMainService topicMainService;

	@Autowired
	PostService postService;

	@RequestMapping(value = "searchBoardName", method = RequestMethod.GET)
	public ModelAndView searchBoardName(String searchKeyword, ModelAndView mav) {
		List<PostDto> searchResultPosts = postService.getPostListBySearchKeyword(searchKeyword);

		mav.addObject("searchResultPosts", searchResultPosts);

		List<TopicMainDto> topicMainList = topicMainService.getTopicMainList();
		TopicMainDto mainDto = new TopicMainDto();
		mainDto.setBoardId(-1);
		mainDto.setBoardTopicName("トピック全体");
		topicMainList.add(mainDto);
		Collections.sort(topicMainList, new TopicMainDtoComparator());
		
		mav.addObject("topicMainMessage", topicMainList);
		mav.addObject("listSize", topicMainList.size());
		
		mav.setViewName("main/topicMain/topicMain");

		return mav;
	}

	@RequestMapping(value = "topicDetail", method = RequestMethod.GET)
	public ModelAndView getPost(long postId, ModelAndView mav) {

		postService.updatePostCount(postId);
		mav.addObject("postDetailDto", postService.postDetailView(postId));
		mav.setViewName("main/topicMain/topicDetail");

		return mav;
	}
	
	public class TopicMainDtoComparator implements Comparator<TopicMainDto> {

		@Override
		public int compare(TopicMainDto p1, TopicMainDto p2) {
			return p1.getBoardId() < p2.getBoardId() ? -1 : 1;
		}
	}
}