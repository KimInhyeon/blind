package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.dto.CompanyRequestDto;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.company.vo.CompanyMainVO;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import com.ksinfo.blind.company.vo.CompanySearchVO;
import com.ksinfo.blind.company.vo.CompanyVoteResultDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CompanyCommonMapper {
	List<CompanyMainVO> getPopularCompanyList();

	List<CompanySearchVO> searchCompany(String companyName);

	void requestCompany(CompanyRequestDto request);

	CompanyMenuVO getCompanyMenu(long companyId);

	List<CompanyJobGroupVO> getJobGroupList();

	//기업선호도 관련
	void setCompanyRecommendVote(Map<String, Object> paramMap); //사용자의 기업선호(추천/비추천) 값을 추가.

	boolean wasCompanyRecommendVoted(long userId, long companyId);

	CompanyVoteResultDto getCompanyRecommendVoteResult(long companyId); //투표한 유저에게 기업의선호도를 출력하기 위해 good/bad 출력.
}