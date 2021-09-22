package com.ksinfo.blind.company.vo;

public final class CompanyVoteResultDto {
	private final int voteCountOfGood;
	private final int voteCountOfBad;

	public CompanyVoteResultDto(float voteCountOfGood, float voteCountOfBad) {
		float tempDenominator = voteCountOfGood + voteCountOfBad;
		if (tempDenominator > 0) {
			this.voteCountOfGood = Math.round(voteCountOfGood / tempDenominator * 100);
			this.voteCountOfBad = Math.round(voteCountOfBad / tempDenominator * 100);
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