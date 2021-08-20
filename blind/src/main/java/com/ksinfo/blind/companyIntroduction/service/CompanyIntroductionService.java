package com.ksinfo.blind.companyIntroduction.service;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.mapper.CompanyIntroductionMapper;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CompanyIntroductionService {
	@Autowired
	private  CompanyIntroductionMapper CompanyIntroductionMapper;
	public CompanyIntroductionDto companyIntroduction(long paramlong){
		return CompanyIntroductionMapper.companyIntro(paramlong);
	}
	public int reviewCount(Long companyId) {
		return CompanyIntroductionMapper.reviewCount(companyId);
	}
	public CompanyAverageDto companyAveragePoint(long companyId) {
		return CompanyIntroductionMapper.companyAveragePoint(companyId);
	}
	public CompanyJoinDto oneCompanyReview(long companyId) {
		return CompanyIntroductionMapper.oneCompanyReview(companyId);
	}
	public List<CompanyJoinDto> companyReviewList(Map<String,Long> paramMap){
		return CompanyIntroductionMapper.companyReviewList(paramMap);
	}
	public void helpCount(Map<String,Long> param) {
		CompanyIntroductionMapper.helpCount(param);
	}
	public CompanyJoinDto searchCompanyRecommend(long companyReviewId){
		return CompanyIntroductionMapper.searchCompanyRecommend(companyReviewId);
	}
	public int checkRecommend(Map<String,Long> paramMap){
		return CompanyIntroductionMapper.checkRecommend(paramMap);
	}
	public void updateHelpCount(Map<String,Long> paramMap){
		CompanyIntroductionMapper.updateHelpCount(paramMap);
	}

/*	public long updatePostRecommend(BookmarkDto searchPostRecommend){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("companyReveiwId", searchPostRecommend.getPostRecommendId());
		return bookmarkMapper.updatePostRecommend(map);
	}*/

}
