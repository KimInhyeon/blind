package com.ksinfo.blind.company.vo;

public final class CompanyVoteResultDto {
	private final int voteCountOfGood;
	private final int voteCountOfBad;

	public CompanyVoteResultDto(float voteCountOfGood, float voteCountOfBad) {
		System.out.println("생성자voteCountOfGood:" + voteCountOfGood);
		System.out.println("생성자voteCountOfBad:" + voteCountOfBad);
		if (voteCountOfGood > 0 || voteCountOfBad > 0) {
			this.voteCountOfGood = Math.round(voteCountOfGood / (voteCountOfGood + voteCountOfBad) * 100);
			this.voteCountOfBad = 100 - this.voteCountOfGood;
			System.out.println("this.voteCountOfGood:" + this.voteCountOfGood);
			System.out.println("this.voteCountOfBad:" + this.voteCountOfBad);
		} else {
			this.voteCountOfGood = this.voteCountOfBad = 0;
		}
	}

	public int getVoteCountOfGood() {
		System.out.println("calledGetGood:" + voteCountOfGood);
		return voteCountOfGood;
	}

	public int getVoteCountOfBad() {
		System.out.println("calledGetBad:" + voteCountOfBad);
		return voteCountOfBad;
	}
}