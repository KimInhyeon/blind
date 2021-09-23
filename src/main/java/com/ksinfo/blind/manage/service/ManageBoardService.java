package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.BoardCreateDto;
import com.ksinfo.blind.manage.dto.BoardUpdateDto;
import com.ksinfo.blind.manage.mapper.ManageBoardMapper;
import com.ksinfo.blind.manage.vo.ManageBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ManageBoardService {
	private final ManageBoardMapper manageBoardMapper;

	@Autowired
	public ManageBoardService(ManageBoardMapper manageBoardMapper) {
		this.manageBoardMapper = manageBoardMapper;
	}

	@Transactional(readOnly = true)
	public List<ManageBoardVO> getBoardList(char closedFlag, char anonymousFlag) {
		return manageBoardMapper.getBoardList(closedFlag, anonymousFlag);
	}

	@Transactional(readOnly = true)
	public int getLastOrder() {
		return manageBoardMapper.getLastOrder();
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public long createBoard(BoardCreateDto board) {
		return manageBoardMapper.createBoard(board);
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public int updateBoard(BoardUpdateDto board) {
		try {
			manageBoardMapper.updateBoard(board);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}