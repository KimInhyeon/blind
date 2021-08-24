package com.ksinfo.blind.common.dto;

import java.util.List;

public final class DirectorySearchDto {
	private final boolean isSearchCompanyName;
	private final List<String> searchKeywordList;

	public DirectorySearchDto(boolean isSearchCompanyName, List<String> searchKeywordList) {
		this.isSearchCompanyName = isSearchCompanyName;
		this.searchKeywordList = searchKeywordList;
	}

	public boolean isSearchCompanyName() {
		return isSearchCompanyName;
	}

	public List<String> getSearchKeywordList() {
		return searchKeywordList;
	}
}