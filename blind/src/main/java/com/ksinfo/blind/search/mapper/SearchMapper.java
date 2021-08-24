package com.ksinfo.blind.search.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.CompanyVoteResultDto;
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

	//기업선호도 관련
	void setCompanyRecommendVote(java.util.Map<String, Object> paramMap); 		//사용자의 기업선호(추천/비추천) 값을 추가.
	List<CompanyVoteResultDto> getCompanyRecommendVoteResult(int companyId); 	//투표한 유저에게 기업의선호도를 출력하기 위해 good/bad 출력.
	

}
