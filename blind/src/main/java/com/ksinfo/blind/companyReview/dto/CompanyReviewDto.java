package com.ksinfo.blind.companyReview.dto;

public class CompanyReviewDto {

	//blind.company_review_mgt as crm

	private int allPoint;                    //crm.all_point 					-- 기업리뷰1-별점(1)총 별점
	private int careerPoint;                //,crm.career_point				-- 기업리뷰2-별점(2)경력점수
	private int workLifeBalancePoint;        //,crm.work_life_balance_point	-- 기업리뷰3-별점(3)워라밸점수
	private int payPoint;                    //,crm.pay_point					-- 기업리뷰4-별점(4)급료점수
	private int companyCulturePoint;        //,crm.company_culture_point		-- 기업리뷰5-별점(5)기업문화점수
	private int headPoint;                    //,crm.head_point					-- 기업리뷰6-별점(6)임원점수(경영진평가)
	private String simpleComment;            //,crm.simple_comment				-- 기업리뷰7-한줄평, 제목역할
	private String userNickname;            //,um.user_nickname					-- 기업리뷰8-작성자 닉네임
	private String recCreateDate;            //,crm.rec_create_date				-- 기업리뷰9-작성일(나중에 create_date 추가필요.)
	private String advantages;                //,crm.advantages					-- 기업리뷰8-장점,
	private String disadvantages;            //,crm.disadvantages				-- 기업리뷰9-단점,
	//										//--	,jgm.job_group_name			-- 작성자 직군(대기/현재 user_job_code컬럼 추가승인 대기중.)
	private int countHelpful;				/*,(select
											count(rri.helpful)
											from blind.review_recommend_inf as rri
											where rri.company_id =#{companyId}
											and rri.company_review_id = crm.company_review_id) as count_helpful --도움이 되었어요는 해당기업의 id에 맞는 것들만 카운트.*/

	public int getAllPoint() {
		return allPoint;
	}

	public void setAllPoint(int allPoint) {
		this.allPoint = allPoint;
	}

	public int getCareerPoint() {
		return careerPoint;
	}

	public void setCareerPoint(int careerPoint) {
		this.careerPoint = careerPoint;
	}

	public int getWorkLifeBalancePoint() {
		return workLifeBalancePoint;
	}

	public void setWorkLifeBalancePoint(int workLifeBalancePoint) {
		this.workLifeBalancePoint = workLifeBalancePoint;
	}

	public int getPayPoint() {
		return payPoint;
	}

	public void setPayPoint(int payPoint) {
		this.payPoint = payPoint;
	}

	public int getCompanyCulturePoint() {
		return companyCulturePoint;
	}

	public void setCompanyCulturePoint(int companyCulturePoint) {
		this.companyCulturePoint = companyCulturePoint;
	}

	public int getHeadPoint() {
		return headPoint;
	}

	public void setHeadPoint(int headPoint) {
		this.headPoint = headPoint;
	}

	public String getSimpleComment() {
		return simpleComment;
	}

	public void setSimpleComment(String simpleComment) {
		this.simpleComment = simpleComment;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}

	public void setRecCreateDate(String recCreateDate) {
		this.recCreateDate = recCreateDate;
	}

	public String getAdvantages() {
		return advantages;
	}

	public void setAdvantages(String advantages) {
		this.advantages = advantages;
	}

	public String getDisadvantages() {
		return disadvantages;
	}

	public void setDisadvantages(String disadvantages) {
		this.disadvantages = disadvantages;
	}

	public int getCountHelpful() {
		return countHelpful;
	}

	public void setCountHelpful(int countHelpful) {
		this.countHelpful = countHelpful;
	}
}