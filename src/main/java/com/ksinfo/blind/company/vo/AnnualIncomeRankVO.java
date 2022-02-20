package com.ksinfo.blind.company.vo;

public class AnnualIncomeRankVO {
    private final int minAnnualIncome;
    private final int avgAnnualIncome;
    private final int maxAnnualIncome;
    private final int userAnnualIncome;
    private final int countOfParticipant;
    private final float userRank;
    private final int businessTypeCode; //메모 시작은 0으로 초기화, 서버에게 받는 처음값은 유저가 일하는 회사의 업계. 이후는 spinner 입력에 따라 변경.
    private final int jobGroupCode;     //메모 시작은 0으로 초기화, 서버에게 받는 처음값은 유저의 직군. 이후는 spinner 입력에 따라 변경.



    public AnnualIncomeRankVO(int minAnnualIncome, int avgAnnualIncome,
                              int maxAnnualIncome, int userAnnualIncome,
                              int countOfParticipant, float userRank,
                              int businessTypeCode, int jobGroupCode)
    {
        this.minAnnualIncome = minAnnualIncome;
        this.avgAnnualIncome = avgAnnualIncome;
        this.maxAnnualIncome = maxAnnualIncome;
        this.userAnnualIncome = userAnnualIncome;
        this.countOfParticipant = countOfParticipant;
        this.userRank = userRank;
        this.businessTypeCode = businessTypeCode;
        this.jobGroupCode = jobGroupCode;


    }
    public int getMinAnnualIncome() { return minAnnualIncome; }
    public int getAvgAnnualIncome() { return avgAnnualIncome; }
    public int getMaxAnnualIncome() { return maxAnnualIncome; }
    public int getUserAnnualIncome() { return userAnnualIncome; }
    public int getCountOfParticipant() { return countOfParticipant; }
    public float getUserRank() { return userRank; }
    public int getBusinessTypeCode() { return businessTypeCode; }
    public int getJobGroupCode() { return jobGroupCode; }
}