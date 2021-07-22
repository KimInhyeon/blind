package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.service.NicknameService;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class NicknameController {
	private final NicknameService nicknameService;

	@Autowired
	public NicknameController(NicknameService nicknameService) {
		this.nicknameService = nicknameService;
	}

	@GetMapping("member/nick-change")
	public ModelAndView nickChange(@AuthenticationPrincipal Account account) {
		ModelAndView modelAndView = new ModelAndView("main/member/nickChange");
		modelAndView.addObject("userNickname", account.getUserNickname());
		modelAndView.addObject("nicknameChangeDate", account.getNicknameChangeDate().getTime());

		return modelAndView;
	}

	@PostMapping("member/nick-change")
	public boolean checkNickname(@RequestBody String newNickname) {
		return nicknameService.checkNickname(newNickname);
	}

	@PatchMapping("member/nick-change")
	public boolean changeNickname(@RequestBody String newNickname, @AuthenticationPrincipal Account account) {
		return nicknameService.changeNickname(newNickname, account);
	}
}