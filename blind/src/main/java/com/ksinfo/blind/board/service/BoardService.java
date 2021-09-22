package com.ksinfo.blind.board.service;

import com.ksinfo.blind.board.dto.SearchBoardPostDto;
import com.ksinfo.blind.board.mapper.BoardMapper;
import com.ksinfo.blind.board.vo.BoardPostVO;
import com.ksinfo.blind.board.vo.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BoardService {
	private final BoardMapper boardMapper;

	@Autowired
	public BoardService(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	@Transactional(readOnly = true)
	public List<BoardVO> getBoardList() {
		return boardMapper.getBoardList();
	}

	@Transactional(readOnly = true)
	public List<BoardVO> getSearchBoardList() {
		return boardMapper.getSearchBoardList();
	}

	@Transactional(readOnly = true)
	public List<BoardPostVO> getBoardPostList(SearchBoardPostDto searchBoardPostDto) {
		return boardMapper.getBoardPostList(searchBoardPostDto);
	}
}