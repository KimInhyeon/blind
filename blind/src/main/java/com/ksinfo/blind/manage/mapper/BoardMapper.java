package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.vo.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface BoardMapper {
	List<BoardVO> getBoardList(char closedFlag, char anonymousFlag);

	int getLastOrder();

	long createBoard(BoardCreateDto board);

	void updateBoard(BoardUpdateDto board);
}