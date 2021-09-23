package com.ksinfo.blind.manage.vo;

public final class ReportVO {
	private final String type;
	private final long targetId;
	private final char verifyFlag;
	private final char completeFlag;
	private final String name;
	private final String reportReason;
	private final String reportCodeReason;
	private final String contents;
	private final String writer;
	private final String reporter;
	private final String reportDate;

	public ReportVO(
		String type, long targetId, char verifyFlag, char completeFlag, String name, String reportReason,
		String reportCodeReason, String contents, String writer, String reporter, String reportDate
	) {
		this.type = type;
		this.targetId = targetId;
		this.verifyFlag = verifyFlag;
		this.completeFlag = completeFlag;
		this.name = name;
		this.reportReason = reportReason;
		this.reportCodeReason = reportCodeReason;
		this.contents = contents;
		this.writer = writer;
		this.reporter = reporter;
		this.reportDate = reportDate;
	}

	public String getType() {
		return type;
	}

	public long getTargetId() {
		return targetId;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public char getCompleteFlag() {
		return completeFlag;
	}

	public String getName() {
		return name;
	}

	public String getReportReason() {
		return reportReason;
	}

	public String getReportCodeReason() {
		return reportCodeReason;
	}

	public String getContents() {
		return contents;
	}

	public String getWriter() {
		return writer;
	}

	public String getReporter() {
		return reporter;
	}

	public String getReportDate() {
		return reportDate;
	}
}