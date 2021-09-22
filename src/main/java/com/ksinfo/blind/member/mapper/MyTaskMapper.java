package com.ksinfo.blind.member.mapper;

import com.ksinfo.blind.member.vo.MyCompanyReviewVO;
import com.ksinfo.blind.member.vo.MyReportVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MyTaskMapper {
	List<MyCompanyReviewVO> getMyCompanyReviewList(long userId);

	List<MyReportVO> getMyReportList(long userId);
}