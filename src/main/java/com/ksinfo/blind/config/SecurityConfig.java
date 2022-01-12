package com.ksinfo.blind.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.ksinfo.blind.security.CustomizeAuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
//			.antMatchers("/manage/**").hasRole("SV")
//			.antMatchers("/image", "/reply", "/post/recommend", "/board").hasAnyRole("SV", "RM")
//			.antMatchers("/member/register", "/member/login", "/member/loginError").anonymous()
//			.antMatchers("/member/registerMemberApp", "/member/loginApp").anonymous()
//			.antMatchers("/", "/main", "/directory", "/search", "/test", "/testAndroidAccess").permitAll()
//			.antMatchers("/post/*", "/company", "/company/search", "/company/annualIncome/*").permitAll()
//			.antMatchers("/company/introduction/*", "/company/news/*", "/company/post/*").permitAll()
//			.antMatchers("/company/review/*", "/company/review/*/*").permitAll()
//			.anyRequest().authenticated()
			.anyRequest().permitAll()
			.and().csrf().disable()
		.formLogin()
			.loginPage("/member/login")
			.defaultSuccessUrl("/member/loginSuccess")
			.failureHandler(new CustomizeAuthenticationFailureHandler())
			.and()
		.logout()
			.logoutUrl("/member/logout")
			.logoutSuccessUrl("/member/login")
			.and()
		.exceptionHandling()
			.accessDeniedPage("/main");
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}