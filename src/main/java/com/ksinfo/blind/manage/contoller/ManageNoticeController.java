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

    @GetMapping
    public ModelAndView manageNotice(
            @RequestParam(name = "selectedNoticeBlindFlag", defaultValue = "0") char selectedNoticeBlindFlag, //closedFlag
            @RequestParam(name = "selectedWirteManager", defaultValue = "0") char selectedWirteManager    //anonymousFlag
    ) {
        //noticeStatusSelect : [메모] 공지여부(공지중/공지않음)를 골라보기 위한 선택값. (0:전체출력 / 1:공지중 / 2:비공지)
        //wirteManagerSelect : [메모] 작성한 관리자를 골라보기 위한 선택값.(0:전체출력 / 1:관리자A / 2:관리자B ..(n명만큼 반복)... )
        //                     [메모] 관리자값은 1,2,3,... 가 아니라 userid로 하게 될거 같다.
        List<NoticeVO> noticeList = manageNoticeService.getNoticeList(selectedNoticeBlindFlag, selectedWirteManager);

        ModelAndView modelAndView = new ModelAndView("main/manage/manageNotices");
        modelAndView.addObject("noticeList", noticeList);
        if (selectedNoticeBlindFlag == '0' && selectedWirteManager == '0') {
            //[메모] 모든 공시글들을 리턴한다.(모든 공시글을 출력하도록.)
            modelAndView.addObject("noticeListSize", noticeList.size());
        }
        /*
        else {
            //[메모] 입력된 공시모드(noticeStatusSelect)와 공시글작성자(wirteManagerSelect)의 값에 따라 검색하여 결과재출력.
            modelAndView.addObject("noticeListSize", manageNoticeService.getLastOrder());
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
