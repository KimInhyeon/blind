package com.ksinfo.blind.common.service;


import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.mapper.MainMapper;
import com.ksinfo.blind.common.vo.BestMainPostVO;
import com.ksinfo.blind.common.vo.SubMainPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MainService {
	private final MainMapper mainMapper;

	@Autowired
	public MainService(MainMapper mainMapper) {
		this.mainMapper = mainMapper;
	}

	@Transactional(readOnly = true)
	public List<BestMainPostVO> getBestMainPostList(){
		return mainMapper.getBestMainPostList();
	}

	@Transactional(readOnly = true)
	public List<SubMainPostVO> getSubMainPostList(){
		return mainMapper.getSubMainPostList();
	}

	@Transactional(readOnly = true)
	public List<BoardVO> getBoardList() {
		return mainMapper.getBoardList();
	}
}