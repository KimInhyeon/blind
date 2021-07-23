package com.ksinfo.blind.search.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostDto;


@Repository
@Mapper 
public interface SearchMapper {
	//ȸ�������� ���� get�޼ҵ�
	List<CompanyDto>getSearchCompany(String searchKeyword);  //searchMapper.xml���� xml�� selectid�� ���Ͻ�Ų��.	
	List<CompanyReviewDto> getCompanyReviews(int companyId);

	
	//����Ʈ ����
	//2.1. �˻��� ����Ʈ ��� ����
	List<PostDto> getSearchPosts(String searchKeyword); 	//����Ʈ ���� ���ذ˻�
	List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword); //�Խñ� ���� ���� �˻�	

	
	//2.2.����Ʈ-���ȼ���(���ʵ�ӹڽ�)
	List<PostDto> getPostSelectTopic(Map<String, Object> paramMap);

	//2.3. ��ӹڽ�-���Ŀɼ�(�ֽ���, ��õ��)
	//2.3.1. �ֽ��� ����
	List<PostDto> getSortPostBylatestDate(Map<String, Object> paramMap); //��ü ���Ľ� boardId �ʿ����.
	//2.3.2. ��õ�� ����
	List<PostDto> getSortPostByRecommend(java.util.Map<String, Object> paramMap); //��õ������ 1���� ������ ����Ʈ�� ����. 

	//
	void setCompanyRecommendVote(java.util.Map<String, Object> paramMap);
}
