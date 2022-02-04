package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.service.NoticeService;
import com.ksinfo.blind.common.vo.NoticeVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("common/notice")
public final class NoticeController {
    private final NoticeService noticeService;

    @Autowired
    public NoticeController(
            NoticeService noticeService
    ) {
        this.noticeService = noticeService;
    }

    //アンドロイド（android）専用のコード。
    @GetMapping("noticeAndroid")
    public List<NoticeVO> getNoticeList(){
        System.out.println("android access noticeAndroid");
        List<NoticeVO>  noticeList = noticeService.getNoticeList();
        System.out.println("noticeList : "+noticeList);
        return noticeList;
    }


}
