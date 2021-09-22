package com.ksinfo.blind.mytask.mapper;

import com.ksinfo.blind.mytask.dto.BookmarkDto;
import com.ksinfo.blind.mytask.dto.MyTopicDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
@Mapper
public interface BookmarkMapper {

	public List<BookmarkDto> bookmarkList(long userId);

	public BookmarkDto searchBookmark(HashMap<String, Object> map);

	public long updateBookmark(HashMap<String, Object> map);

	//2021-09-07 추가
	public void insertBookmark(HashMap<String, Object> map);				//새로 북마크row추가

	public BookmarkDto searchPostRecommend(HashMap<String, Object> map);

	public long insertPostRecommend(HashMap<String, Object> map);

	public long updatePostRecommend(HashMap<String, Object> map);
}
