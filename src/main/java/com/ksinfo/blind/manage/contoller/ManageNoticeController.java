package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.manage.service.ManageNoticeService;

import com.ksinfo.blind.manage.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@RestController
@RequestMapping("manage/notice")
public final class ManageNoticeController {
    private final ManageNoticeService manageNoticeService;

    @Autowired
    public ManageNoticeController(ManageNoticeService manageNoticeService) {
        this.manageNoticeService = manageNoticeService;
    }

    @GetMapping
    public ModelAndView manageNotice(
            @RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
            @RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
    ) {
        List<NoticeVO> noticeList = manageNoticeService.getNoticeList(closedFlag, anonymousFlag);

        ModelAndView modelAndView = new ModelAndView("main/manage/manageNotice");
        modelAndView.addObject("noticeList", noticeList);

        if (closedFlag == '0' && anonymousFlag == '2') {
            modelAndView.addObject("lastOrder", noticeList.size());
        }
        /*
        else {
            modelAndView.addObject("lastOrder", manageBoardService.getLastOrder());
        }
        */
        return modelAndView;
    }



    @GetMapping(params = "ajax=true")
    public List<NoticeVO> getNoticeList(
            @RequestParam(name = "closedFlag", defaultValue = "0") char closedFlag,
            @RequestParam(name = "anonymousFlag", defaultValue = "2") char anonymousFlag
    ) {
         return manageNoticeService.getNoticeList(closedFlag, anonymousFlag);
    }

    /*
    @PostMapping
    public long createNotice(@RequestBody BoardCreateDto board, @AuthenticationPrincipal Account account) {
        board.setUserId(account.getUserId());
        return manageBoardService.createBoard(board);
    }
    */

}
