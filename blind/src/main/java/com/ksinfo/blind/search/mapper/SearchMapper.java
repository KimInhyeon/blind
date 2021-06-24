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

	
	//����Ʈ ����
	//2.1.����Ʈ ��� ����
	List<PostDto> getSearchPosts(String searchKeyword); 	//����Ʈ ���� ���ذ˻�
	List<UserDto> getNicknameAndCompanynameOfPosts(int userId);	//�Խñ� �ۼ����� ����(�г���,�ٹ�ȸ��) 

	List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword); //�Խñ� ���� ���� �˻�	
	List<ReplyDto> getReplysOfPosts(int postId);
	List<PostCountInfDto> getViewCountOfPosts(int postId);	//�Խñ� ��ȸ�� ī��Ʈ

	//��ӹڽ� ���� �ɼ�
	List<BoardDto> getBoardTopicName(int boardId);
	

	List<PostAlignDto> getsortPostBylatestDate(String searchKeyword);//�ֽ��� ����
	List<PostDto> getPostsOfOneTopic(java.util.Map<String, Object> paramMap); //��õ�� ����
	List<Integer> getRecommendCountOfPosts(int postId);	//����Ʈ�� ��õ�� ī��Ʈ		
	List<Integer> getReplyCountsOfPosts(int postId);	//����Ʈ�� ��ۼ� ī��Ʈ
	
	
	
	//(2)â�ִ԰�� ->������ ����� ������ ī��Ʈ
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java�� ���� ��ü ����. ������ ������ �𸣰ڴ�.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
