package com.ksinfo.blind.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
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
        .antMatchers("/admin/**").hasRole("SV")
        .antMatchers("/user/**").hasRole("RM")
        .antMatchers("/", "/main", "/registMember").permitAll()
        .anyRequest().authenticated()
        .and().csrf().disable()
    .formLogin()           
        .loginPage("/login")
        .defaultSuccessUrl("/loginSuccess")
        .failureHandler(new CustomizeAuthenticationFailureHandler())
        .permitAll()
        .and()
    .logout()         
        .permitAll()
        .and()
    .exceptionHandling()
        .accessDeniedPage("/login");
	}
	
	@Bean
	public PasswordEncoder passwordEncoder(){
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
