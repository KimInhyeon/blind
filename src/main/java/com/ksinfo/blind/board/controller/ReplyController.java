package com.ksinfo.blind.board.controller;

import com.ksinfo.blind.board.dto.ReplyDto;
import com.ksinfo.blind.board.dto.ReplyRecommendDto;
import com.ksinfo.blind.board.dto.ReplyRequestDto;
import com.ksinfo.blind.board.dto.ReplyUpdateDto;
import com.ksinfo.blind.board.service.ReplyService;
import com.ksinfo.blind.board.vo.RefreshVO;
import com.ksinfo.blind.board.vo.ReplyRecommendVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
	public long writeReply(@AuthenticationPrincipal Account account, @RequestBody ReplyDto reply) {
		reply.setUserId(account.getUserId());

		return replyService.writeReply(reply);
	}

	@PutMapping
	public void updateReply(@AuthenticationPrincipal Account account, @RequestBody ReplyUpdateDto reply) {
		reply.setUserId(account.getUserId());
		replyService.updateReply(reply);
	}

	@DeleteMapping
	public void deleteReply(@AuthenticationPrincipal Account account, @RequestBody long replyId) {
		replyService.deleteReply(account.getUserId(), replyId);
	}

	@PostMapping("recommend")
	public ReplyRecommendVO recommendReply(@AuthenticationPrincipal Account account, @RequestBody long replyId) {
		ReplyRecommendDto replyRecommendDto = new ReplyRecommendDto(account.getUserId(), replyId);

		return replyService.recommendReply(replyRecommendDto);
	}
}