package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.vo.NoticeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NoticeMapper {
    List<NoticeVO> getNoticeListForUsers();
}
