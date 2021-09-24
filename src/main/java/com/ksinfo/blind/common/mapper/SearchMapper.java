package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.board.vo.BoardVO;
import com.ksinfo.blind.common.dto.SearchPostDto;
import com.ksinfo.blind.common.vo.SearchBoardVO;
import com.ksinfo.blind.common.vo.SearchCompanyVO;
import com.ksinfo.blind.common.vo.SearchPostVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SearchMapper {
	List<BoardVO> getBoardSliderList();

	List<SearchCompanyVO>getSearchCompanyList(String searchKeyword);

	List<SearchBoardVO> getSearchBoardList(String searchKeyword);

	List<SearchPostVO> getPostList(SearchPostDto search);
}