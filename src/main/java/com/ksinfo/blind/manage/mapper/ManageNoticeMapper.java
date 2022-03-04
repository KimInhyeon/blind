package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.vo.NoticeVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface ManageNoticeMapper {

    List<NoticeVO> getNoticeListForManager(java.util.Map<String, Object> paramMap);
    List<NoticeVO> getNoticeListForManagerSelectedColumn(java.util.Map<String, Object> paramMap);
    void      insertNewNotice(java.util.Map<String, Object> paramMap);
    void updateOriginalNotice(java.util.Map<String, Object> paramMap);

}
