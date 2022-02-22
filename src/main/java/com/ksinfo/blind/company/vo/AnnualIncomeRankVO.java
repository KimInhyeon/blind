package com.ksinfo.blind.company.vo;

public class AnnualIncomeRankVO {
    private final int minAnnualIncome;
    private final int avgAnnualIncome;
    private final int maxAnnualIncome;
    private final int userAnnualIncome;
    private final int countOfParticipant;
    private final float userRank;



    public AnnualIncomeRankVO(int minAnnualIncome, int avgAnnualIncome,
                              int maxAnnualIncome, int userAnnualIncome,
                              int countOfParticipant, float userRank)
    {
        this.minAnnualIncome = minAnnualIncome;
        this.avgAnnualIncome = avgAnnualIncome;
        this.maxAnnualIncome = maxAnnualIncome;
        this.userAnnualIncome = userAnnualIncome;
        this.countOfParticipant = countOfParticipant;
        this.userRank = userRank;
    }

    public int getMinAnnualIncome() { return minAnnualIncome; }
    public int getAvgAnnualIncome() { return avgAnnualIncome; }
    public int getMaxAnnualIncome() { return maxAnnualIncome; }
    public int getUserAnnualIncome() { return userAnnualIncome; }
    public int getCountOfParticipant() { return countOfParticipant; }
    public float getUserRank() { return userRank; }
}