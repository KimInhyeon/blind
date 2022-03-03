package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.ManageNoticeMapper;
import com.ksinfo.blind.manage.vo.ManageBoardVO;
import com.ksinfo.blind.manage.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Service
public class ManageNoticeService {
    private final ManageNoticeMapper manageNoticeMapper;

    @Autowired
    public ManageNoticeService(ManageNoticeMapper manageNoticeMapper)
    {
        this.manageNoticeMapper = manageNoticeMapper;
    }

    //
    @Transactional(readOnly = true)
    public List<NoticeVO> getNoticeListForManager(char selectedNoticeType, char selectedNoticeBlindFlag,
                                                  Integer selectedWirteManager)
    {
        java.util.Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("selectedNoticeType", selectedNoticeType);
        paramMap.put("selectedNoticeBlindFlag", selectedNoticeBlindFlag);
        paramMap.put("selectedWirteManager", selectedWirteManager);
        return manageNoticeMapper.getNoticeListForManager(paramMap);
    }

    @Transactional(readOnly = true)
    public List<NoticeVO> getNoticeListForManagerSelectedColumn(char selectedNoticeType,
                                                                char selectedNoticeBlindFlag,
                                                                Integer selectedWirteManager)
    {
        java.util.Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("selectedNoticeType", selectedNoticeType);
        paramMap.put("selectedNoticeBlindFlag", selectedNoticeBlindFlag);
        paramMap.put("selectedWirteManager", selectedWirteManager);
        return manageNoticeMapper.getNoticeListForManagerSelectedColumn(paramMap);
    }


    public void insertNewNotice(long userId, String sendNoticeTypeCode, String sendNoticeTitle,
                                String sendNoticeContents, String sendNoticeBlindFlag)
    {
        java.util.Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("sendNoticeTypeCode", sendNoticeTypeCode);
        paramMap.put("sendNoticeTitle", sendNoticeTitle);
        paramMap.put("sendNoticeContents", sendNoticeContents);
        paramMap.put("sendNoticeBlindFlag", sendNoticeBlindFlag);

        /*
            System.out.println("paramMap userId : " + paramMap.get("userId"));
            System.out.println("paramMap sendNoticeTypeCode : " + paramMap.get("sendNoticeTypeCode"));
            System.out.println("paramMap sendNoticeTitle : " + paramMap.get("sendNoticeTitle"));
            System.out.println("paramMap sendNoticeContents : " + paramMap.get("sendNoticeContents"));
            System.out.println("paramMap sendNoticeBlindFlag : " + paramMap.get("sendNoticeBlindFlag"));
        */
        manageNoticeMapper.insertNewNotice(paramMap);
    }

    public void updateOriginalNotice(long userId, String sendNoticeId, String sendNoticeTypeCode,
                                     String sendNoticeTitle, String sendNoticeContents, String sendNoticeBlindFlag)
    {
        java.util.Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("sendNoticeId", sendNoticeId);
        paramMap.put("sendNoticeTypeCode", sendNoticeTypeCode);
        paramMap.put("sendNoticeTitle", sendNoticeTitle);
        paramMap.put("sendNoticeContents", sendNoticeContents);
        paramMap.put("sendNoticeBlindFlag", sendNoticeBlindFlag);

        /*
            System.out.println("paramMap userId : " + paramMap.get("userId"));
            System.out.println("paramMap sendNoticeId : " + paramMap.get("sendNoticeId"));
            System.out.println("paramMap sendNoticeTypeCode : " + paramMap.get("sendNoticeTypeCode"));
            System.out.println("paramMap sendNoticeTitle : " + paramMap.get("sendNoticeTitle"));
            System.out.println("paramMap sendNoticeContents : " + paramMap.get("sendNoticeContents"));
            System.out.println("paramMap sendNoticeBlindFlag : " + paramMap.get("sendNoticeBlindFlag"));
        */

        manageNoticeMapper.updateOriginalNotice(paramMap);
    }
}
