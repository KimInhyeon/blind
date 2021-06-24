package com.ksinfo.blind.search.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostAlignDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.dto.UserDto;


@Repository
@Mapper 
public interface SearchMapper {
	//ȸ�������� ���� get�޼ҵ�
	List<CompanyDto>getSearchCompany(String searchKeyword);  //searchMapper.xml���� xml�� selectid�� ���Ͻ�Ų��.	
	List<CompanyReviewDto> getCompanyReviews(int companyId);

	
	//���ñ� ���� get�޼ҵ� ����
	List<PostDto> getSearchPosts(String searchKeyword); 	//�˻���� ���õ� ����Ʈ(�Խñ�) �˻�
	List<UserDto> getNicknameAndCompanynameOfPosts(int userId);	//�˻���� �Խñۿ� ���� �ۼ����� ����(�г���,�ٹ�ȸ��) 
	
	List<PostCountInfDto> getViewCountOfPosts(int postId);	//�Խñ� ��ȸ�� ī��Ʈ

	
	List<ReplyDto> getReplysOfPosts(int postId);

	List<BoardDto> getBoardTopicName(int boardId);
	List<PostAlignDto> getsortPostBylatestDate(String searchKeyword);
	List<PostDto> getPostsOfOneTopic(java.util.Map<String, Object> paramMap);

	List<Integer> getBoardTopicCount(String searchKeyword); 
	List<Integer> getRecommendCountOfPosts(int postId);
	List<Integer> getReplyCountsOfPosts(int postId);
	
	//(2)â�ִ԰�� ->������ ����� ������ ī��Ʈ
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java�� ���� ��ü ����. ������ ������ �𸣰ڴ�.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
