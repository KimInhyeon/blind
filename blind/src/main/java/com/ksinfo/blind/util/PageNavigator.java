package com.ksinfo.blind.util;

public final class PageNavigator {
	private final int currentPage;
	private final int startPage;
	private final int endPage;
	private final int totalPage;
	private final int pagination;

	public PageNavigator(int page, int totalRecord, final int recordLimit, final int pagination) {
		if (totalRecord <= recordLimit) {
			currentPage = startPage = endPage = totalPage = 1;
		} else {
			totalPage = (totalRecord + recordLimit - 1) / recordLimit;
			if (page > totalPage) {
				currentPage = totalPage;
			} else if (page > 0) {
				currentPage = page;
			} else {
				currentPage = 1;
			}
			if (totalPage <= pagination) {
				startPage = 1;
				endPage = totalPage;
			} else {
				startPage = (currentPage - 1) / pagination * pagination + 1;
				endPage = Math.min(startPage + pagination - 1, totalPage);
			}
		}
		this.pagination = pagination;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getPagination() {
		return pagination;
	}
}