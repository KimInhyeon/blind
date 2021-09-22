package com.ksinfo.blind.manage.dto;

import java.util.Comparator;
import java.util.List;

public final class ReportVerifyDto {
	private long userId;
	private final char verifyFlag;
	private final String reason;
	private final List<Report> reportList;

	public static final class Report {
		private final char type;
		private final long targetId;

		public Report(char type, long targetId) {
			this.type = type;
			this.targetId = targetId;
		}

		public char getType() {
			return type;
		}

		public long getTargetId() {
			return targetId;
		}
	}

	public ReportVerifyDto(char verifyFlag, String reason, List<Report> reportList) {
		reportList.sort(new Comparator<Report>() {
			@Override
			public int compare(Report o1, Report o2) {
				if (o1.getType() == o2.getType()) {
					return Long.compare(o1.getTargetId(), o2.getTargetId());
				}
				return o1.getType() - o2.getType();
			}
		});
		for (int i = reportList.size() - 1; i > 0; --i) {
			Report o1 = reportList.get(i);
			Report o2 = reportList.get(i - 1);
			if (o1.getType() == o2.getType() && o1.getTargetId() == o2.getTargetId()) {
				reportList.remove(i);
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

	public List<Report> getReportList() {
		return reportList;
	}
}