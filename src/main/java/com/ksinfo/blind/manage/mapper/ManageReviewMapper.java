package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.ReviewSearchDto;
import com.ksinfo.blind.manage.dto.ReviewVerifyDto;
import com.ksinfo.blind.manage.vo.CompanyReviewVO;
import com.ksinfo.blind.manage.vo.ReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface ManageReviewMapper {
	int getTotalReviewRecord(ReviewSearchDto reviewSearchDto);

	List<ReviewVO> getReviewList(RowBounds rowBounds, ReviewSearchDto reviewSearchDto);

	CompanyReviewVO getReview(long companyReviewId);

	int verifyReview(ReviewVerifyDto reviewVerifyDto);
}