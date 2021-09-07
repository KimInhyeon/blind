package com.ksinfo.blind.mytask.controller;

import com.ksinfo.blind.mytask.dto.BookmarkDto;
import com.ksinfo.blind.mytask.service.BookmarkService;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;

@Controller
public class BookmarkController {

    @Autowired
    BookmarkService bookmarkService;

    @RequestMapping(value = "/bookmark")
    public ModelAndView bookmarkView(@AuthenticationPrincipal Account account, ModelAndView mv) {
        mv.addObject("bookmarkList", bookmarkService.bookmarkList(account.getUserId()));
        mv.setViewName("main/mytask/bookmark");
        return mv;
    }

    @RequestMapping(value = "addBookmark", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void addBookmark(@AuthenticationPrincipal Account account, long postId) {
        BookmarkDto searchBookmark = bookmarkService.searchBookmark(account.getUserId(), postId);
            if (searchBookmark != null) {
            bookmarkService.updateBookmark(searchBookmark);
            }
        }

    //북마크 없음을 확인한 경우 신규 row를 추가.
    @RequestMapping(value = "insertBookmark", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void insertBookmark(@AuthenticationPrincipal Account account, long postId) {
        BookmarkDto searchBookmark = bookmarkService.searchBookmark(account.getUserId(), postId);
        if (searchBookmark != null) {
            bookmarkService.updateBookmark(searchBookmark);
        }
    }

    //해당 북마크의 logical_del_flag(on/off여부)칼럼값을 받는다. 이를 리턴하여 jsp의 ajax로 on/off표현.
    @RequestMapping(value = "checkNowBookmarkFlag", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void checkNowBookmarkFlag(@AuthenticationPrincipal Account account, long postId) {

    }


    @RequestMapping(value = "addPostRecommend", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void addPostRecommend(@AuthenticationPrincipal Account account, long postId){
        BookmarkDto searchPostRecommend = bookmarkService.searchPostRecommend(account.getUserId(), postId);
        List<BookmarkDto> prlist = new ArrayList<BookmarkDto>();
        prlist.add(searchPostRecommend);
        if(searchPostRecommend == null) {
            bookmarkService.insertPostRecommend(account.getUserId(), postId);
        }else if(prlist.size() > 0){
            bookmarkService.updatePostRecommend(searchPostRecommend);
        }
    }

}
