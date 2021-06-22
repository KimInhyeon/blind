package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.service.MemberService;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginView() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("main/member/login");
		return mv;
	}

	@RequestMapping(value = "/loginError")
	public ModelAndView loginSubmit() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("main/member/login");
		return mv;
	}

	@RequestMapping(value = "/loginSuccess")
	public ModelAndView loginSuccess() {
		ModelAndView mv = new ModelAndView();

		SecurityContext context = SecurityContextHolder.getContext();

		Authentication authentication = context.getAuthentication();

		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iter = authorities.iterator();

		List<String> strAuth = new ArrayList<String>();

		while (iter.hasNext()) {
			GrantedAuthority auth = iter.next();
			strAuth.add(auth.getAuthority());
		}
		mv.addObject("auth", strAuth.get(0));
		mv.setViewName("main/member/loginSuccess");
		return mv;
	}

	@RequestMapping(value = "/registMember", method = RequestMethod.GET)
	public ModelAndView signInView() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("main/member/registMember");
		return mv;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request) {
		String inputEmail = request.getParameter("username");

		memberService.loadUserByUsername(inputEmail);
	}

/*	@RequestMapping(value = "/registMember", method = RequestMethod.POST)
	public ModelAndView signIn(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Account account = new Account();

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String nickName = request.getParameter("nickName");
		String role = request.getParameter("role");

		account.setUserEmail(username);
		account.setUserPassword(password);
		account.setUserNickname(nickName);

		if (role.equals("NM")) {
			account.setUserAuth("ROLE_NM");
		} else if (role.equals("RM")) {
			account.setUserAuth("ROLE_RM");
		} else if (role.equals("SV")) {
			account.setUserAuth("ROLE_SV");
		}

		int registedCount = memberService.registNewMember(account);

		mv.setViewName("main/main");
		return mv;
	}*/
	@RequestMapping(value = "/registMember", method = RequestMethod.POST)
	public ModelAndView signIn(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Account account = new Account();

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String nickName = request.getParameter("nickName");

		// TODO: nullエラー臨時対策、後で必ず確認
		String role = "NM";

		account.setUserEmail(username);
		account.setUserPassword(password);
		account.setUserNickname(nickName);

		if (role.equals("NM")) {
			account.setUserAuth("ROLE_NM");
		} else if (role.equals("RM")) {
			account.setUserAuth("ROLE_RM");
		} else if (role.equals("SV")) {
			account.setUserAuth("ROLE_SV");
		}

		int registedCount = memberService.registNewMember(account);

		mv.setViewName("main/main");
		return mv;
	}
}