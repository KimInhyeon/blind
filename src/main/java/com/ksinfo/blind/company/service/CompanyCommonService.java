package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.dto.CompanyRequestDto;
import com.ksinfo.blind.company.mapper.CompanyCommonMapper;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.company.vo.CompanyMainVO;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import com.ksinfo.blind.company.vo.CompanySearchVO;
import com.ksinfo.blind.company.vo.CompanyVoteResultDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CompanyCommonService {
	private final CompanyCommonMapper companyCommonMapper;


	@Autowired
	public CompanyCommonService(CompanyCommonMapper companyCommonMapper) {
		this.companyCommonMapper = companyCommonMapper;
	}

	@Transactional(readOnly = true)
	public List<CompanyMainVO> getPopularCompanyList() {
		return companyCommonMapper.getPopularCompanyList();
	}

	public void requestCompany(CompanyRequestDto request){
		companyCommonMapper.requestCompany(request);
	}

	@Transactional(readOnly = true)
	public CompanyMenuVO getCompanyMenu(long companyId) {
		CompanyMenuVO companyMenu = companyCommonMapper.getCompanyMenu(companyId);
		if (companyMenu == null) {
			throw new NullPointerException();
		}

		return companyMenu;
	}

	@Transactional(readOnly = true)
	public List<CompanySearchVO> searchCompany(String companyName){
		return companyCommonMapper.searchCompany(companyName);
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupList() {
		return companyCommonMapper.getJobGroupList();
	}

	//유저가 선택한 해당기업에 대한 추천/비추천 값을 추가.
	public void setCompanyRecommendVote(long userId, long companyId, int companyVoteValue) {
		Map<String, Object> paramMap = new HashMap<>(3);
		//COMPANY_RECOMMEND_INF에 기업추천/비추천을 위해 필요한 정보들을 준비.
		paramMap.put("userId", userId);
		paramMap.put("companyId", companyId);
		paramMap.put("companyVoteValue", companyVoteValue);
		companyCommonMapper.setCompanyRecommendVote(paramMap);
	}

	//기업선호도 투표한 유저에게 결과(기업선호도)를 출력하기 위해 리턴.
	@Transactional(readOnly = true)
	public CompanyVoteResultDto getCompanyRecommendVoteResult(long userId, long companyId) {
		if (companyCommonMapper.wasCompanyRecommendVoted(userId, companyId)) {
			CompanyVoteResultDto companyVoteResultDto = companyCommonMapper.getCompanyRecommendVoteResult(companyId);
			companyVoteResultDto = new CompanyVoteResultDto(companyVoteResultDto.getVoteCountOfGood(),companyVoteResultDto.getVoteCountOfBad());


			return companyVoteResultDto;
		}

		return null;
	}
}