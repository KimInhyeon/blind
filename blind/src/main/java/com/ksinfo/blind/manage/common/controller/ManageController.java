package com.ksinfo.blind.manage.common.controller;

import javax.servlet.http.HttpSession;

public abstract class ManageController {
	protected final static String main = "main/test/test";

	protected boolean authCheck(HttpSession session) {
		return session.getAttribute("auth").equals("SV");
	}
}