package com.ksinfo.blind.member.mapper;

import com.ksinfo.blind.member.dto.BookmarkDto;
import com.ksinfo.blind.member.vo.BookmarkPostVO;
import com.ksinfo.blind.member.vo.BookmarkVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookmarkMapper {
	List<BookmarkPostVO> getMyBookmarkList(long userId);

	BookmarkVO searchBookmark(BookmarkDto bookmarkDto);

	void addBookmark(BookmarkDto bookmarkDto);

	void updateBookmark(long bookmarkId, long userId);
}