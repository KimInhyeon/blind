package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.mapper.DirectoryMapper;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import com.ksinfo.blind.util.SearchCompanyNameManager;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DirectoryService {
	private static final int recordLimit = 4;
	private static final int pagination = 5;
	private final SearchCompanyNameManager searchCompanyNameManager;
	private final DirectoryMapper directoryMapper;

	@Autowired
	public DirectoryService(SearchCompanyNameManager searchCompanyNameManager, DirectoryMapper directoryMapper) {
		this.searchCompanyNameManager = searchCompanyNameManager;
		this.directoryMapper = directoryMapper;
	}

	public DirectorySearchDto getDirectorySearchDto(StringBuilder searchKeyword) {
		boolean isSearchCompanyName = searchCompanyNameManager.isSearchCompanyName(searchKeyword);
		List<String> searchKeywordList = searchCompanyNameManager.getSearchKeywordList(searchKeyword);

		return new DirectorySearchDto(isSearchCompanyName, searchKeywordList);
	}

	@Transactional(readOnly = true)
	public PageNavigator getDirectoryNavigator(int page, DirectorySearchDto directorySearchDto) {
		int totalRecord = directoryMapper.getTotalDirectoryRecord(directorySearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<DirectoryCompanyVO> getDirectoryCompanyList(int page, DirectorySearchDto directorySearchDto) {
		int offset = (page - 1) * recordLimit;
		return directoryMapper.getDirectoryCompanyList(new RowBounds(offset, recordLimit), directorySearchDto);
	}

}