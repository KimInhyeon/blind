package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface DirectoryMapper {
	int getTotalDirectoryRecord(DirectorySearchDto directorySearchDto);

	List<DirectoryCompanyVO> getDirectoryCompanyList(RowBounds rowBounds, DirectorySearchDto directorySearchDto);
}