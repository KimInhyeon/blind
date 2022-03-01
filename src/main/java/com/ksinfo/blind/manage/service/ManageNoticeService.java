package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.ManageNoticeMapper;
import com.ksinfo.blind.manage.vo.ManageBoardVO;
import com.ksinfo.blind.manage.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

}
