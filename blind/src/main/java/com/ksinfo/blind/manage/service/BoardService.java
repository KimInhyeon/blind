package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.mapper.BoardMapper;
import com.ksinfo.blind.manage.vo.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
	private final BoardMapper boardMapper;

	@Autowired
	public BoardService(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	public List<BoardVO> getBoardList(char closedFlag, char anonymousFlag) {
		return boardMapper.getBoardList(closedFlag, anonymousFlag);
	}

	public int getLastOrder() {
		return boardMapper.getLastOrder();
	}

	public long createBoard(BoardCreateDto board) {
		return boardMapper.createBoard(board);
	}

	public int updateBoard(BoardUpdateDto board) {
		try {
			boardMapper.updateBoard(board);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}