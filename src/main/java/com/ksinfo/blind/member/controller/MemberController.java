package com.ksinfo.blind.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.member.dto.RegisterMemberDto;
import com.ksinfo.blind.member.service.MemberService;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.MessageUtils;

@Controller
@RequestMapping("member")
public final class MemberController {
	private final MemberService memberService;
	private final MessageUtils messageUtils;

	@Autowired
	public MemberController(MemberService memberService, MessageUtils messageUtils) {
		this.memberService = memberService;
		this.messageUtils = messageUtils;
	}

	@GetMapping("login")
	public ModelAndView loginView() {
		ModelAndView modelAndView = new ModelAndView("main/member/login");
		modelAndView.addObject("title", "ログイン");

		return modelAndView;
	}

	@PostMapping("login")
	public void login(HttpServletRequest request) {
		String inputEmail = request.getParameter("username");
		memberService.loadUserByUsername(inputEmail);
	}

	@GetMapping("loginSuccess")
	public ModelAndView loginSuccess(@AuthenticationPrincipal Account account) {
		ModelAndView modelAndView = new ModelAndView("main/member/loginSuccess");
		modelAndView.addObject("title", "KSINFOSYS BLIND");
		modelAndView.addObject("userId", account.getUserId());
		modelAndView.addObject("auth", account.getAuthorities().get(0));

		return modelAndView;
	}

	@PostMapping(value = "loginError")
	public ModelAndView loginSubmit() {
		ModelAndView modelAndView = new ModelAndView("main/member/login");
		modelAndView.addObject("title", "ログイン");

		return modelAndView;
	}

	@GetMapping("register")
	public ModelAndView signInView() {
		ModelAndView modelAndView = new ModelAndView("main/member/registerMember");
		modelAndView.addObject("title", "KSINFOSYS BLIND");

		return modelAndView;
	}

	@PostMapping("register")
	public String signIn(RegisterMemberDto member) {
		memberService.registerNewMember(member);

		return "redirect:/";
	}

	@GetMapping("nickname")
	public ModelAndView nickChange(@AuthenticationPrincipal Account account) {
		ModelAndView modelAndView = new ModelAndView("main/member/nickname");
		modelAndView.addObject("title", "ニックネーム変更");
		modelAndView.addObject("userNickname", account.getUserNickname());
		modelAndView.addObject("nicknameChangeDate", account.getNicknameChangeDate().getTime());

		return modelAndView;
	}

	@ResponseBody
	@PostMapping("nickname")
	public boolean checkNickname(@RequestBody String newNickname) {
		return memberService.checkNickname(newNickname);
	}

	@ResponseBody
	@PatchMapping("nickname")
	public boolean changeNickname(@RequestBody String newNickname, @AuthenticationPrincipal Account account) {
		return memberService.changeNickname(newNickname, account);
	}

	@ResponseBody
	@PostMapping("loginApp")
	public Map<String, String> loginApp(HttpServletRequest request) {
		Map<String, String> result = new HashMap<>();
		String inputEmail = request.getParameter("username");
		String inputPw = request.getParameter("password");
		Account account = (Account) memberService.loadUserByUsername(inputEmail);

		try {
			if (memberService.checkPassword(inputPw, account.getPassword())) {
				result.put("message", "OK");
			} else {
				String message = messageUtils.getMessage("BLIND_ERR_MSG_003");
				result.put("message", message);
			}

		} catch (UsernameNotFoundException e) {
			String message = messageUtils.getMessage("BLIND_ERR_MSG_001");
			result.put("message", message);
		}

		return result;
	}

	@ResponseBody
	@PostMapping("/registMemberApp")
	public Map<String, String> signInApp(RegisterMemberDto member) {
//		int result = memberService.registerNewMember(member);
		int result = 1;
		memberService.registerNewMember(member);

		Map<String, String> response = new HashMap<>(1);
		if (result > 0) {
			response.put("message", messageUtils.getMessage("BLIND_SCS_MSG_001"));
			response.put("code", "BLIND_SCS_MSG_001");
		} else {
			response.put("message", messageUtils.getMessage("BLIND_ERR_MSG_002"));
			response.put("code", "BLIND_SCS_MSG_002");
		}

		return response;
	}
}