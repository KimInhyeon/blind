package com.ksinfo.blind.member.service;

import com.ksinfo.blind.member.vo.MyPostVO;
import com.ksinfo.blind.member.mapper.MyPostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MyPostService {
    private final MyPostMapper myPostMapper;

	@Autowired
	public MyPostService(MyPostMapper myPostMapper) {
		this.myPostMapper = myPostMapper;
	}

	@Transactional(readOnly = true)
	public List<MyPostVO> getMyPostList(long userId){

		return myPostMapper.getMyPostList(userId);
	}
}