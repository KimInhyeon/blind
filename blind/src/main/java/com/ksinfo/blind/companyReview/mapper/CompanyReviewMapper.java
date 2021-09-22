package com.ksinfo.blind.companyReview.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.ksinfo.blind.mytask.dto.BookmarkDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.companyReview.dto.CompanyReviewDto;

@Repository
@Mapper
public interface CompanyReviewMapper {
	List<CompanyDto> companySearch(String paramString);
	List<CompanyDto> companySearchAll();
	int companyReviewJoin(CompanyJoinDto inputDto);
	List<CompanyMainViewDto> companySearchPopular();

	//BLIND_0013_企業登録申請(2021-08-05)
	void sendRequestCompanyRegist(java.util.Map<String, Object> paramMap);

	//BLIND_0017_企業ポストタブ(2021-08-11)
	String getCompanyName(int companyId);
	int getTotalRecord(Map<String, Object> paramMap );
	List<PostDto> getPosts(RowBounds row, Map<String, Object> paramMap );

	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	List<CompanyReviewDto> getCompanyReviews(int companyId);

	//企業レビュー詳細照会（0016）-「役立ちます」機能追加。(기업리뷰-도움이 되었습니다 기능추가.)
	CompanyReviewDto searchHelpful(HashMap<String, Object> map); //도움이 되었습니다. 버튼 클릭시 해당기업리뷰에 이전에 등록된 추천기록(레코드)가 있는지 확인.

	/* 아직 작성중입니다-START(코드의 작동을 위해 임시로 주석처리)
	long insertHelpful(HashMap<String, Object> map); //searchHelpful 확인결과 컨트롤러에서 신규추가 실시할 때 사용.
	long updateHelpful(HashMap<String, Object> map); //searchHelpful 확인결과 컨트롤러에서 기존등록 있을 시 추천여부만 갱신 때 사용.
	아직 작성중입니다-END(코드의 작동을 위해 임시로 주석처리) */
}
