package com.ksinfo.blind.topicMain.controller;

import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.topicMain.dto.ReplyDto;
import com.ksinfo.blind.topicMain.dto.ReplyResultDto;
import com.ksinfo.blind.topicMain.service.ReplyService;
import com.ksinfo.blind.topicMain.service.TopicMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {

	@Autowired
	ReplyService replyService;

	@Autowired
	TopicMainService topicMainService;

	@RequestMapping(value = "/insertReply", method = RequestMethod.POST)
	@ResponseBody
	public List<ReplyResultDto> insertReply(@AuthenticationPrincipal Account account, ReplyDto dto) throws Exception {

		dto.setUserId(account.getUserId());
		replyService.insertReply(dto);
		List<ReplyResultDto> readReply = replyService.readReply(dto.getPostId());
		long resultCount = topicMainService.replyCount(dto.getPostId());

		if (readReply != null) {
			readReply.get(0).setReplyCount(resultCount);
		} else {

		}

		return readReply;
	}

	@RequestMapping(value = "/readReply")
	public ModelAndView readReply(@RequestParam long postId, ModelAndView mav) {

		List<ReplyResultDto> readReply = replyService.readReply(postId);
		mav.setViewName("/reply/replyList");
		mav.addObject("readReply", readReply);
		return mav;
	}
}