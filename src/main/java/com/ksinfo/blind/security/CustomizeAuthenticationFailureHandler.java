package com.ksinfo.blind.security;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public final class CustomizeAuthenticationFailureHandler implements AuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(
		HttpServletRequest req, HttpServletResponse res, AuthenticationException exception
	) throws IOException, ServletException {
		// TODO Auto-generated method stub
/*
		String email = req.getParameter("username");
		String strPassword = req.getParameter("password");
		req.setAttribute(email, email);
		req.setAttribute(strPassword, strPassword);
 */
		String errorMsg = null;
		if (exception instanceof BadCredentialsException || exception instanceof UsernameNotFoundException) {
			errorMsg = exception.getMessage();
		}

		req.setAttribute("errorMsg", errorMsg);
		req.getRequestDispatcher("/member/loginError").forward(req, res);
	}
}