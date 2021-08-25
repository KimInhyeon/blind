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
			.antMatchers("/manage/**").hasRole("SV")
			.antMatchers("/board", "/upload", "/post").hasAnyRole("SV", "RM")
			.antMatchers("/registMember", "/registMemberApp", "/login", "/loginApp").anonymous()
			.antMatchers("/", "/main", "/testAndroidAccess", "/directory", "/companyReviewMain").permitAll()
			.antMatchers("/companyIntroduction", "/companyNews/**").permitAll()
			.anyRequest().authenticated()
			.and().csrf().disable()
		.formLogin()
			.loginPage("/login")
			.defaultSuccessUrl("/loginSuccess")
			.failureHandler(new CustomizeAuthenticationFailureHandler())
			.and()
		.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/login")
			.and()
		.exceptionHandling()
			.accessDeniedPage("/main");
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}