package com.ksinfo.blind.manage.dto;

import java.util.Comparator;
import java.util.List;

public final class ReportVerifyDto {
	private long userId;
	private final char verifyFlag;
	private final String reason;
	private final List<Report> reportList;

	private static final class Report {
		private final char type;
		private final long targetId;

		private Report(char type, long targetId) {
			this.type = type;
			this.targetId = targetId;
		}
	}

	public ReportVerifyDto(char verifyFlag, String reason, List<Report> reportList) {
		reportList.sort(new Comparator<Report>() {
			@Override
			public int compare(Report o1, Report o2) {
				return o1.type - o2.type;
			}
		});
		for (int i = reportList.size() - 1; i > 0; --i) {
			Report report = reportList.get(i);
			for (int j = i - 1; j > -1 && report.type == reportList.get(j).type; --j) {
				if (report.targetId == reportList.get(j).targetId) {
					reportList.remove(j);
					--i;
				}
			}
		}
		this.verifyFlag = verifyFlag;
		this.reason = reason;
		this.reportList = reportList;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public String getReason() {
		return reason;
	}

	public List<Report> getVerifyList() {
		return reportList;
	}
}