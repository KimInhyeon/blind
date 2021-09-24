package com.ksinfo.blind.common.service;

import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.dto.SearchPostDto;
import com.ksinfo.blind.common.mapper.SearchMapper;
import com.ksinfo.blind.common.vo.SearchBoardVO;
import com.ksinfo.blind.common.vo.SearchCompanyVO;
import com.ksinfo.blind.common.vo.SearchPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SearchService {
	private final SearchMapper searchMapper;

	@Autowired
	public SearchService(SearchMapper searchMapper) {
		this.searchMapper = searchMapper;
	}

	@Transactional(readOnly = true)
	public List<SearchPostVO> getPostList(SearchPostDto search) {
		return searchMapper.getPostList(search);
	}

	@Transactional(readOnly = true)
	public List<BoardVO> getBoardSliderList() {
		return searchMapper.getBoardSliderList();
	}

	@Transactional(readOnly = true)
	public List<SearchBoardVO> getSearchBoardList(String searchKeyword) {
		return searchMapper.getSearchBoardList(searchKeyword);
	}

	@Transactional(readOnly = true)
	public List<SearchCompanyVO> getSearchCompanyList(String searchKeyword) {
		return searchMapper.getSearchCompanyList(searchKeyword);
	}
}