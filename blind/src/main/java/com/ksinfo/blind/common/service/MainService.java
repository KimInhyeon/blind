package com.ksinfo.blind.common.service;


import com.ksinfo.blind.common.dto.CommonPostDto;
import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.mapper.MainMapper;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.util.SearchCompanyNameManager;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainService {
	private static final int recordLimit = 4;
	private static final int pagination = 5;
	private final MainMapper mainMapper;
	private final SearchCompanyNameManager searchCompanyNameManager;

	@Autowired
	public MainService(MainMapper mainMapper, SearchCompanyNameManager searchCompanyNameManager) {
		this.mainMapper = mainMapper;
		this.searchCompanyNameManager = searchCompanyNameManager;
	}

	public List<CommonPostDto> topicBestList(){
		return mainMapper.topicBestList();
	}

	public List<CommonPostDto> topicSubList(){
		return mainMapper.topicSubList();
	}

	public DirectorySearchDto getDirectorySearchDto(StringBuilder searchKeyword) {
		boolean isSearchCompanyName = searchCompanyNameManager.isSearchCompanyName(searchKeyword);
		List<String> searchKeywordList = searchCompanyNameManager.getSearchKeywordList(searchKeyword);

		return new DirectorySearchDto(isSearchCompanyName, searchKeywordList);
	}

	public PageNavigator getDirectoryNavigator(int page, DirectorySearchDto directorySearchDto) {
		int totalRecord = mainMapper.getDirectoryTotalRecord(directorySearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	public List<DirectoryCompanyVO> getDirectoryCompanyList(int page, DirectorySearchDto directorySearchDto) {
		int offset = (page - 1) * recordLimit;
		return mainMapper.getDirectoryCompanyList(new RowBounds(offset, recordLimit), directorySearchDto);
	}
}