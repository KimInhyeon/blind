package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.ReplyDto;
import com.ksinfo.blind.board.dto.ReplyRecommendDto;
import com.ksinfo.blind.board.dto.ReplyRequestDto;
import com.ksinfo.blind.board.dto.ReplyUpdateDto;
import com.ksinfo.blind.board.vo.RefreshVO;
import com.ksinfo.blind.board.vo.ReplyRecommendVO;
import com.ksinfo.blind.board.vo.ReplyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {
	RefreshVO getRefreshCounts(ReplyRequestDto replyRequest);

	List<ReplyVO> getReplyList(ReplyRequestDto replyRequest);

	void writeReply(ReplyDto reply);

	void updateReply(ReplyUpdateDto reply);

	void deleteReply(long userId, long replyId);

	long getLatestReplyId(long userId, long postId);

	Long getReplyRecommendId(ReplyRecommendDto replyRecommendDto);

	void recommendReply(ReplyRecommendDto replyRecommendDto);

	void updateReplyRecommend(Long replyRecommendId);

	ReplyRecommendVO getReplyRecommendResult(ReplyRecommendDto replyRecommendDto);
}