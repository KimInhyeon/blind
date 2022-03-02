package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.manage.service.ManageNoticeService;

import com.ksinfo.blind.manage.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
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
        @RequestParam(name = "selectedNoticeBlindFlag", defaultValue = "2") char selectedNoticeBlindFlag,
        @RequestParam(name = "selectedWirteManager", defaultValue = "0") Integer selectedWirteManager)
    {
         return manageNoticeService.getNoticeListForManagerSelectedColumn(selectedNoticeType, selectedNoticeBlindFlag, selectedWirteManager);
    }

    @RequestMapping(value = "manage/notices/insertNewNotice", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void insertNewNotice(String sendNoticeId, String sendNoticeTypeCode, String sendNoticeTitle,
                                          String sendNoticeContents, String sendNoticeBlindFlag)
    {
        System.out.println("Access manage/notices/insertNewNotice");
       // return manageNoticeService.getNoticeListForManagerSelectedColumn(selectedNoticeType, selectedNoticeBlindFlag, selectedWirteManager);
    }

//    @RequestMapping(value = "manage/notices/updateOriginalNotice", method = RequestMethod.POST, produces = "application/json")
//    @ResponseBody
    @ResponseBody
    @PostMapping("manage/notices/updateOriginalNotice")
    public void updateOriginalNotice(String sendNoticeId, String sendNoticeTypeCode, String sendNoticeTitle,
                                     String sendNoticeContents, String sendNoticeBlindFlag)
    {
        System.out.println("Access manage/notices/updateOriginalNotice");
        // return manageNoticeService.getNoticeListForManagerSelectedColumn(selectedNoticeType, selectedNoticeBlindFlag, selectedWirteManager);
    }


    @RequestMapping(value = "/testConnect", method = RequestMethod.POST)
    @ResponseBody
    public void testConnect()
    {
        System.out.println("Access manage/notices/testConnect");
    }

    /*
    @PostMapping
    public long createNotice(@RequestBody BoardCreateDto board, @AuthenticationPrincipal Account account) {
        board.setUserId(account.getUserId());
        return manageBoardService.createBoard(board);
    }
    */

}
