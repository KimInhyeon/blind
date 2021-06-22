package com.ksinfo.blind.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomizeAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res,
			AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub

		String email = req.getParameter("username");
		String strPassword = req.getParameter("password");

		req.setAttribute(email, email);
		req.setAttribute(strPassword, strPassword);

		String errorMsg = null;

		if (exception instanceof BadCredentialsException) {
			errorMsg = exception.getMessage();
		} else if (exception instanceof UsernameNotFoundException) {
			errorMsg = exception.getMessage();
		}

		req.setAttribute("errorMsg", errorMsg);

		System.out.println(errorMsg);
		req.getRequestDispatcher("/loginError").forward(req, res);
	}
}