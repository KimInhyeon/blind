package com.ksinfo.blind.member.service;

import com.ksinfo.blind.member.dto.BookmarkDto;
import com.ksinfo.blind.member.mapper.BookmarkMapper;
import com.ksinfo.blind.member.vo.BookmarkPostVO;
import com.ksinfo.blind.member.vo.BookmarkVO;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookmarkService {
	private static final int limit = 15;
	private final BookmarkMapper bookmarkMapper;

	@Autowired
	public BookmarkService(BookmarkMapper bookmarkMapper) {
		this.bookmarkMapper = bookmarkMapper;
	}

	public boolean bookmark(BookmarkDto bookmarkDto) {
		BookmarkVO bookmark = bookmarkMapper.searchBookmark(bookmarkDto);
		if (bookmark == null) {
			bookmarkMapper.addBookmark(bookmarkDto);
			return true;
		}
		bookmarkMapper.updateBookmark(bookmark.getBookmarkId(), bookmarkDto.getUserId());
		return bookmark.getLogicalDelFlag() == '1';
	}

	@Transactional(readOnly = true)
	public List<BookmarkPostVO> getMyBookmarkList(long userId, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return bookmarkMapper.getMyBookmarkList(userId, rowBounds);
	}
}