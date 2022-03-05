package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.vo.NoticeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManageNoticeMapper {

    List<NoticeVO> getNoticeList(char closedFlag, char anonymousFlag);

}
