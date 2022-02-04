package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.mapper.NoticeMapper;
import com.ksinfo.blind.common.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NoticeService {
    private final NoticeMapper noticeMapper;

    @Autowired
    public NoticeService(NoticeMapper noticeMapper)
    {
        this.noticeMapper = noticeMapper;
    }

    @Transactional(readOnly = true)
    public List<NoticeVO> getNoticeList() {
        return noticeMapper.getNoticeList();
    }


}
