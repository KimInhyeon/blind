package com.ksinfo.blind.company.vo;

public final class CompanyVoteResultDto {
	private final int voteCountOfGood;
	private final int voteCountOfBad;

	public CompanyVoteResultDto(float voteCountOfGood, float voteCountOfBad) {
		if (voteCountOfGood > 0 || voteCountOfBad > 0) {
			this.voteCountOfGood = Math.round(voteCountOfGood / (voteCountOfGood + voteCountOfBad) * 100);
			this.voteCountOfBad = 100 - this.voteCountOfGood;
		} else {
			this.voteCountOfGood = this.voteCountOfBad = 0;
		}
	}

	public int getVoteCountOfGood() {
		return voteCountOfGood;
	}

	public int getVoteCountOfBad() {
		return voteCountOfBad;
	}
}