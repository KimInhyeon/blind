package com.ksinfo.blind.post.controller;

import com.ksinfo.blind.post.dto.PostDto;
import com.ksinfo.blind.post.dto.PostFileDto;
import com.ksinfo.blind.post.service.PostService_Temp;
import com.ksinfo.blind.post.vo.PostFileVO;
import com.ksinfo.blind.post.vo.TopicVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
public class PostController {
	private final PostService_Temp postService;

	@Autowired
	public PostController(PostService_Temp postService) {
		this.postService = postService;
	}

	@GetMapping(value = "board")
	public List<TopicVO> getTopicList() {
		return postService.getTopicList();
	}

	@DeleteMapping(value = "upload")
	public int deleteUploadedFile(@AuthenticationPrincipal Account account, @RequestBody long postFileId) {
		return postService.deleteUploadedFile(account.getUserId(), postFileId);
	}

	@PostMapping(value = "upload")
	public List<PostFileVO> uploadFile(@AuthenticationPrincipal Account account, long postId, MultipartFile[] files) {
		PostFileDto postFileDto = new PostFileDto(account.getUserId(), postId);
		return postService.uploadFile(postFileDto, files);
	}

	@PostMapping(value = "post")
	public long writePost(@AuthenticationPrincipal Account account, @RequestBody PostDto postDto) {
		postDto.setUserId(account.getUserId());
		return postService.writePost(postDto);
	}
}