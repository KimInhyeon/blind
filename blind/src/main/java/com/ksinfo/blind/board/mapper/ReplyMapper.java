package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.ReplyRequestDto;
import com.ksinfo.blind.board.vo.RefreshVO;
import com.ksinfo.blind.board.vo.ReplyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {
	RefreshVO getRefreshCounts(ReplyRequestDto replyRequest);

	List<ReplyVO> getReplyList(ReplyRequestDto replyRequest);
}