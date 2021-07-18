package com.ksinfo.blind.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.common.service.MemberService;
import com.ksinfo.blind.security.Account;

@Controller
public class MemberController  {
	
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
    public ModelAndView loginSuccess(@AuthenticationPrincipal Account account) {
        ModelAndView mv = new ModelAndView();
        
		/*
		 * SecurityContext context = SecurityContextHolder.getContext();
		 * 
		 * Authentication authentication = context.getAuthentication();
		 * 
		 * Collection<? extends GrantedAuthority> authorities =
		 * authentication.getAuthorities(); Iterator<? extends GrantedAuthority> iter =
		 * authorities.iterator();
		 * 
		 * List<String> strAuth = new ArrayList<String>();
		 * 
		 * while (iter.hasNext()) { GrantedAuthority auth = iter.next();
		 * strAuth.add(auth.getAuthority()); }
		 */
        mv.addObject("userId", account.getUserId());
        mv.addObject("auth", account.getUserAuth());
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
	
	@RequestMapping(value = "/registMember", method = RequestMethod.POST)
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
    }
}
