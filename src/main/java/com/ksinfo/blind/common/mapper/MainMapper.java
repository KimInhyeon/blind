package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.vo.BestMainPostVO;
import com.ksinfo.blind.common.vo.SubMainPostVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MainMapper {
	List<BestMainPostVO> getBestMainPostList();

	List<SubMainPostVO> getSubMainPostList();

	List<BoardVO> getBoardList();
}