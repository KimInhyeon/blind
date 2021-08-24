package com.ksinfo.blind.topicMain.controller;

import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.dto.ReplyDto;
import com.ksinfo.blind.topicMain.dto.ReplyResultDto;
import com.ksinfo.blind.topicMain.dto.TopicMainDto;
import com.ksinfo.blind.topicMain.service.PostService;
import com.ksinfo.blind.topicMain.service.ReplyService;
import com.ksinfo.blind.topicMain.service.TopicMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
public class TopicMainController {

	@Autowired
	TopicMainService topicMainService;

	@Autowired
	PostService postService;

	@Autowired
	ReplyService replyService;

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
	public ModelAndView getPost(HttpServletRequest request, HttpServletResponse response, long postId, ModelAndView mav) {

        Cookie[] cookies = request.getCookies();

        Cookie viewCookie = null;

        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("cookie"+postId)) {
                    viewCookie = cookies[i];
                }
            }
        }

        if (viewCookie == null) {
        	Cookie newCookie = new Cookie("cookie"+ postId, "|" + postId + "|");
        	response.addCookie(newCookie);
        	postService.updatePostCount(postId);
        }

		long resultCount;
		resultCount = topicMainService.replyCount(postId);

		mav.addObject("postDetailDto", postService.postDetailView(postId));
		mav.addObject("ReplyDto", new ReplyDto());
		mav.addObject("resultCount", resultCount);
		List<ReplyResultDto> readReply = replyService.readReply(postId);
		mav.addObject("readReply", readReply);
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