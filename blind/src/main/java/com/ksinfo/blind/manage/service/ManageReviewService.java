package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.ReviewSearchDto;
import com.ksinfo.blind.manage.dto.ReviewVerifyDto;
import com.ksinfo.blind.manage.mapper.ManageReviewMapper;
import com.ksinfo.blind.manage.vo.CompanyReviewVO;
import com.ksinfo.blind.manage.vo.ReviewVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ManageReviewService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final ManageReviewMapper manageReviewMapper;

	@Autowired
	public ManageReviewService(ManageReviewMapper manageReviewMapper) {
		this.manageReviewMapper = manageReviewMapper;
	}

	@Transactional(readOnly = true)
	public PageNavigator getNavigator(int page, ReviewSearchDto reviewSearchDto) {
		int totalRecord = manageReviewMapper.getTotalReviewRecord(reviewSearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<ReviewVO> getReviewList(int page, ReviewSearchDto reviewSearchDto) {
		int offset = (page - 1) * recordLimit;
		return manageReviewMapper.getReviewList(new RowBounds(offset, recordLimit), reviewSearchDto);
	}

	@Transactional(readOnly = true)
	public CompanyReviewVO getReview(long companyReviewId) {
		return manageReviewMapper.getReview(companyReviewId);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	public int verifyReview(ReviewVerifyDto reviewVerifyDto) {
		try {
			return manageReviewMapper.verifyReview(reviewVerifyDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}