package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.dto.CompanyReviewRecommendDto;
import com.ksinfo.blind.company.dto.CompanyReviewSearchDto;
import com.ksinfo.blind.company.dto.CompanyReviewWriteDto;
import com.ksinfo.blind.company.mapper.CompanyReviewMapper;
import com.ksinfo.blind.company.vo.CompanyReviewAverageVO;
import com.ksinfo.blind.company.vo.CompanyReviewRecommendResultVO;
import com.ksinfo.blind.company.vo.CompanyReviewVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class CompanyReviewService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final CompanyReviewMapper companyReviewMapper;

	@Autowired
	public CompanyReviewService(CompanyReviewMapper companyReviewMapper) {
		this.companyReviewMapper = companyReviewMapper;
	}

	public void writeCompanyReview(CompanyReviewWriteDto companyReview) {
		companyReviewMapper.writeCompanyReview(companyReview);
	}

	@Transactional(readOnly = true)
	public CompanyReviewAverageVO getReviewAveragePoint(long companyId) {
		return companyReviewMapper.getReviewAveragePoint(companyId);
	}

	@Transactional(readOnly = true)
	public PageNavigator getNavigator(int page, long companyId) {
		int totalRecord = companyReviewMapper.getTotalReviewRecord(companyId);

		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<CompanyReviewVO> getCompanyReviewList(CompanyReviewSearchDto search, int page) {
		int offset = (page - 1) * recordLimit;
		RowBounds rowBounds = new RowBounds(offset, recordLimit);
		List<CompanyReviewVO> companyList = companyReviewMapper.getCompanyReviewList(search, rowBounds);
		// ログインしていないユーザーに仮想のユーザーIDを付与し、一行目のレビューを再度読み込む
		if (page == 1 && search.getUserId() == 0L && !companyList.isEmpty()) {
			search.setUserId(Long.MAX_VALUE);
			rowBounds = new RowBounds(0, 1);
			List<CompanyReviewVO> company = companyReviewMapper.getCompanyReviewList(search, rowBounds);
			companyList.set(0, company.get(0));
		}

		return companyList;
	}

	public CompanyReviewRecommendResultVO recommendReview(CompanyReviewRecommendDto reviewRecommendDto) {
		Long reviewRecommendId = companyReviewMapper.findReviewRecommendId(reviewRecommendDto);
		if (reviewRecommendId == null) {
			companyReviewMapper.recommendReview(reviewRecommendDto);
		} else {
			companyReviewMapper.updateReviewRecommend(reviewRecommendId);
		}

		return companyReviewMapper.getReviewRecommendResult(reviewRecommendDto);
	}

	public String getCompanyName(long companyId) {
		return companyReviewMapper.getCompanyName(companyId);
	}


	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	public List<CompanyReviewVO> getCompanyReviews(long companyId) {
		return companyReviewMapper.getCompanyReviews(companyId);
	}
}