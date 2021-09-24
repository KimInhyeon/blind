package com.ksinfo.blind.companyIntroduction.service;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.mapper.CompanyIntroductionMapper;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CompanyIntroductionService {
	private static final int recordLimit=10;
	private static final int pagination=5;

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
	public CompanyJoinDto oneCompanyReview(Map<String,Long> paramMap) {
		return CompanyIntroductionMapper.oneCompanyReview(paramMap);
	}
	public List<CompanyJoinDto> companyReviewList(Map<String,Long> paramMap,int page){
		int offset = (page-1)*recordLimit;
		RowBounds rowBounds = new RowBounds(offset,recordLimit);



		return CompanyIntroductionMapper.companyReviewList(paramMap,rowBounds);


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

	public PageNavigator getNavigator(int page, Long companyId) {

		Map<String,Object> map = new HashMap<>(2);
		map.put("page",page);
		map.put("companyId",companyId);
		int totalRecord = CompanyIntroductionMapper.getTotalRecord(map);
		return new PageNavigator(page,totalRecord,recordLimit,pagination);
	}
	public int getReviewWrite(long userId){
		return CompanyIntroductionMapper.getReviewWrite(userId);
	}

/*	public long updatePostRecommend(BookmarkDto searchPostRecommend){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("companyReveiwId", searchPostRecommend.getPostRecommendId());
		return bookmarkMapper.updatePostRecommend(map);
	}*/

}
