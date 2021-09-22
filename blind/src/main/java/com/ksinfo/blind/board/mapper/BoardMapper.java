package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.SearchBoardPostDto;
import com.ksinfo.blind.board.vo.BoardPostVO;
import com.ksinfo.blind.board.vo.BoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
	List<BoardVO> getBoardList();

	List<BoardVO> getSearchBoardList();

	List<BoardPostVO> getBoardPostList(SearchBoardPostDto searchBoardPostDto);
}