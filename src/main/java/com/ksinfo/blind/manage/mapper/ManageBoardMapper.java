package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.vo.ManageBoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManageBoardMapper {
	List<ManageBoardVO> getBoardList(char closedFlag, char anonymousFlag);

	int getLastOrder();

	long createBoard(BoardCreateDto board);

	void updateBoard(BoardUpdateDto board);
}