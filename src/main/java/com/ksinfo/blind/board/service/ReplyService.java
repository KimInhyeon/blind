package com.ksinfo.blind.board.service;

import com.ksinfo.blind.board.dto.ReplyRequestDto;
import com.ksinfo.blind.board.mapper.ReplyMapper;
import com.ksinfo.blind.board.vo.RefreshVO;
import com.ksinfo.blind.board.vo.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReplyService {
	private final ReplyMapper replyMapper;

	@Autowired
	public ReplyService(ReplyMapper replyMapper) {
		this.replyMapper = replyMapper;
	}

	@Transactional(readOnly = true)
	public List<ReplyVO> getReplyList(ReplyRequestDto replyRequest) {
		return replyMapper.getReplyList(replyRequest);
	}

	@Transactional(readOnly = true)
	public RefreshVO refreshReply(ReplyRequestDto replyRequest) {
		RefreshVO result = replyMapper.getRefreshCounts(replyRequest);
		result.setReplyList(replyMapper.getReplyList(replyRequest));

		return result;
	}
}