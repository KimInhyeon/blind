package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.DirectorySearchDto;
import com.ksinfo.blind.common.vo.BestMainPostVO;
import com.ksinfo.blind.common.vo.DirectoryCompanyVO;
import com.ksinfo.blind.common.vo.SubMainPostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface MainMapper {
	List<BestMainPostVO> getBestMainPostList();

	List<SubMainPostVO> getSubMainPostList();

	int getTotalDirectoryRecord(DirectorySearchDto directorySearchDto);

	List<DirectoryCompanyVO> getDirectoryCompanyList(RowBounds rowBounds, DirectorySearchDto directorySearchDto);
}