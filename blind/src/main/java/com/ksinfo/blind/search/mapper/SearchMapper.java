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

	//2.2. ��ӹڽ� ���� �ɼ�
	//2.2.1. �ֽ��� ����
	List<PostDto> getSortPostAllTopicBylatestDate(String searchKeyword); //��ü ���Ľ� boardId �ʿ����.
//	List<PostDto> getSortPostAllTopicBylatestDate(String searchKeyword,int boardId); //��ü ���Ľ� boardId �ʿ����.
//	List<PostDto> getSortPostOneTopicBylatestDate(String searchKeyword,); //1�� ���ȼ��ý� boardId �ʿ���.

	//2.2.2. �ֽ��� ����
	List<PostDto> getPostsOfOneTopic(java.util.Map<String, Object> paramMap); //��õ�� ����
	
	

}
