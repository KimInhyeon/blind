package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.CommonPostDto;
import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MainMapper {
	List<CommonPostDto> topicBestList(); //토픽베스트

	List<CommonPostDto> topicSubList();

	int getDirectoryTotalRecord(DirectorySearchDto directorySearchDto);

	List<DirectoryCompanyVO> getDirectoryCompanyList(RowBounds rowBounds, DirectorySearchDto directorySearchDto);
}