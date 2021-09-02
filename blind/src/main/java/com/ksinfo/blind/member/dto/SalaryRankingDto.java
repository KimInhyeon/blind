package com.ksinfo.blind.member.dto;

public class SalaryRankingDto {
	private int userId; 			//user_id          --bigint not null
	private int salaryRanking;		//, ROW_NUMBER() over(order by salary desc) AS salaryranking

	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getSalaryRanking() {
		return salaryRanking;
	}
	public void setSalaryRanking(int salaryRanking) {
		this.salaryRanking = salaryRanking;
	}

}
