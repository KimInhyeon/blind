package com.ksinfo.blind.util;

public class PageNavigator {
	private int currentPage;
	private int startPage;
	private int endPage;
	private int totalPage;
	private int pagination;

	public PageNavigator(int page, int totalRecord, final int recordLimit, final int pagination) {
		if (totalRecord <= recordLimit) {
			currentPage = startPage = endPage = totalPage = 1;
		} else {
			totalPage = (totalRecord + recordLimit - 1) / recordLimit;
			if (page > totalPage) {
				currentPage = totalPage;
			} else if (page < 1) {
				currentPage = 1;
			} else {
				currentPage = page;
			}
			if (totalPage <= pagination) {
				startPage = 1;
				endPage = totalPage;
			} else {
				startPage = (currentPage - 1) / pagination * pagination + 1;
				endPage = startPage + pagination - 1;
				if (endPage > totalPage) {
					endPage = totalPage;
				}
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