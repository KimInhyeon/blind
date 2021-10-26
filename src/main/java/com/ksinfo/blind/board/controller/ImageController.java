package com.ksinfo.blind.board.controller;

import com.ksinfo.blind.board.service.ImageService;
import com.ksinfo.blind.board.vo.PostEditFileVO;
import com.ksinfo.blind.board.vo.PostFileVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("image")
public final class ImageController {
	private final ImageService imageService;

	@Autowired
	public ImageController(ImageService imageService) {
		this.imageService = imageService;
	}

	@GetMapping(params = "postId")
	public PostFileVO getPostFile(
		@AuthenticationPrincipal Account account, @RequestParam long postId,
		@RequestParam String fileHash, @RequestParam String originName
	) {
		return imageService.getPostFile(account.getUserId(), postId, fileHash, originName);
	}

	@PostMapping(params = "postId")
	public PostFileVO getPostFile(@AuthenticationPrincipal Account account, long postId, MultipartFile file) {
		return imageService.getPostFile(account.getUserId(), postId, file);
	}

	@GetMapping
	public String getFileUrl(@RequestParam String fileHash) {
		return imageService.getReplyFileUrl(fileHash);
	}

	@PostMapping
	public String getFileUrl(MultipartFile file) {
		return imageService.getReplyFileUrl(file);
	}

	@DeleteMapping
	public boolean deleteUploadedFile(@AuthenticationPrincipal Account account, @RequestBody long postFileId) {
		return imageService.deleteUploadedFile(account.getUserId(), postFileId);
	}

	@GetMapping("{postId}")
	public List<PostEditFileVO> getPostFileList(
		@AuthenticationPrincipal Account account, @PathVariable long postId
	) {
		return imageService.getPostFileList(account.getUserId(), postId);
	}
}