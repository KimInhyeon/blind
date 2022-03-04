package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.manage.service.ManageNoticeService;

import com.ksinfo.blind.manage.vo.NoticeVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@RestController
@RequestMapping("manage/notices")
public final class ManageNoticeController {
    private final ManageNoticeService manageNoticeService;

    @Autowired
    public ManageNoticeController(ManageNoticeService manageNoticeService) {
        this.manageNoticeService = manageNoticeService;
    }

    //最初に公知事項管理ページを出力する時に使うコード。
    //메모 관리자가 표헤더필터를 통해 선택한 컬럼(옵션)들로 출력하는 코드는 getNoticeListForManagerSelectedColumn(){...}를 참고해주십시오.
    @GetMapping
    public ModelAndView manageNotice(
        @RequestParam(name = "selectedNoticeType", defaultValue = "0") char selectedNoticeType,
        @RequestParam(name = "selectedNoticeBlindFlag", defaultValue = "2") char selectedNoticeBlindFlag,
        @RequestParam(name = "selectedWirteManager", defaultValue = "0") Integer selectedWirteManager)
    {
        //selectedNoticeBlindFlag：公知文のタイプを選んで出力する。(0：公知中 / 1： 非知中  / 2：公知文全体 )
        //selectedWirteManager    : [메모] 작성한 관리자를 골라보기 위한 선택값.(0:전체출력 / 1:관리자A / 2:관리자B ..(n명만큼 반복)... )
        //                          [메모] 관리자값은 1,2,3,... 가 아니라 userid로 하게 될거 같다.

        ModelAndView modelAndView = new ModelAndView("main/manage/manageNotices");

        List<NoticeVO> noticeList = manageNoticeService.getNoticeListForManager(selectedNoticeType, selectedNoticeBlindFlag, selectedWirteManager);
        modelAndView.addObject("noticeList", noticeList);
        modelAndView.addObject("noticeListSize", noticeList.size());
        return modelAndView;
    }

    //메모 관리자가 표의 헤더필터에서 선택한 옵션에 따라 공지목록을 새로 Select하여 JSP에게 리턴하여 새로 출력하는 메소드.
    @GetMapping(params = "ajax=true")
    public List<NoticeVO> getNoticeListForManagerSelectedColumn(
        @RequestParam(name = "selectedNoticeType", defaultValue = "0") char selectedNoticeType,
        @RequestParam(name = "selectedNoticeBlindFlag", defaultValue = "2") char selectedNoticeBlindFlag)
        //@RequestParam(name = "selectedWirteManager", defaultValue = "0") Integer selectedWirteManager)
    {
        //return manageNoticeService.getNoticeListForManagerSelectedColumn(selectedNoticeType, selectedNoticeBlindFlag, selectedWirteManager);
        return manageNoticeService.getNoticeListForManagerSelectedColumn(selectedNoticeType, selectedNoticeBlindFlag);
    }

    //메모 ajax통신을 체크하기 위한 코드.
    @RequestMapping(value = "/testConnect", method = RequestMethod.POST)
    @ResponseBody
    public void testConnect()
    {
        System.out.println("Access manage/notices/testConnect");
    }

    @RequestMapping(value = "/insertNewNotice", method = RequestMethod.POST)
    @ResponseBody
    public List<NoticeVO> insertNewNotice(@AuthenticationPrincipal Account account,
                                          String sendNoticeTypeCode, String sendNoticeTitle,
                                          String sendNoticeContents, String sendNoticeBlindFlag)
    {
        System.out.println("Access manage/notices/insertNewNotice");
        long userId = account.getUserId();
        manageNoticeService.insertNewNotice(userId, sendNoticeTypeCode, sendNoticeTitle,
                                            sendNoticeContents, sendNoticeBlindFlag );
        return manageNoticeService.getNoticeListForManagerSelectedColumn('0', '2');
    }

    @RequestMapping(value = "/updateOriginalNotice", method = RequestMethod.POST)
    @ResponseBody
    public List<NoticeVO> updateOriginalNotice(@AuthenticationPrincipal Account account,
                                               String sendNoticeId, String sendNoticeTypeCode, String sendNoticeTitle,
                                               String sendNoticeContents, String sendNoticeBlindFlag)
    {
        System.out.println("Access manage/notices/updateOriginalNotice");
        long userId = account.getUserId();

        System.out.println("userId : " + userId );
        System.out.println("sendNoticeId : " + sendNoticeId );
        System.out.println("sendNoticeTypeCode : " + sendNoticeTypeCode );
        System.out.println("sendNoticeTitle : " + sendNoticeTitle );
        System.out.println("sendNoticeContents : " + sendNoticeContents );
        System.out.println("sendNoticeBlindFlag : " + sendNoticeBlindFlag );

        manageNoticeService.updateOriginalNotice(userId, sendNoticeId, sendNoticeTypeCode,
                                                 sendNoticeTitle,sendNoticeContents, sendNoticeBlindFlag);
        return manageNoticeService.getNoticeListForManagerSelectedColumn('0', '2');
    }


}
