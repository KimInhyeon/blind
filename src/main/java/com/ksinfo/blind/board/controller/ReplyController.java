package com.ksinfo.blind.board.controller;

import com.ksinfo.blind.board.dto.ReplyRequestDto;
import com.ksinfo.blind.board.service.ReplyService;
import com.ksinfo.blind.board.vo.RefreshVO;
import com.ksinfo.blind.board.vo.ReplyVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("reply")
public final class ReplyController {
	private final ReplyService replyService;

	@Autowired
	public ReplyController(ReplyService replyService) {
		this.replyService = replyService;
	}

	@GetMapping
	public RefreshVO refreshReply(@AuthenticationPrincipal Account account, @RequestParam long postId) {
		ReplyRequestDto replyRequest = new ReplyRequestDto(account.getUserId(), postId);

		return replyService.refreshReply(replyRequest);
	}

	@PostMapping
	public List<ReplyVO> writeReply() {
		return null;
	}
}