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

}
