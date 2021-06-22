package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.mapper.MemberMapper;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.MessageUtils;
import com.ksinfo.blind.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService implements UserDetailsService {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	SecurityUtil securityUtil;
	@Autowired
	MessageUtils messages;

/*	@Override
	public UserDetails loadUserByUsername(String inputEmail) throws UsernameNotFoundException {
		Account account = memberMapper.findMemberByEmail(securityUtil.encryptSHA256(inputEmail));

		if (account == null) {
			throw new UsernameNotFoundException(messages.getMessage("BLIND_ERR_MSG_001"));
		}

		account.setAuthorities(getAuthorities(account.getUserAuth()));

		UserDetails userDetails = new UserDetails() {

			private static final long serialVersionUID = 1L;

			@Override
			public boolean isEnabled() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isCredentialsNonExpired() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isAccountNonLocked() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isAccountNonExpired() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public String getUsername() {
				// TODO Auto-generated method stub
				return account.getUsername();
			}

			@Override
			public String getPassword() {
				// TODO Auto-generated method stub
				return account.getPassword();
			}

			@Override
			public Collection getAuthorities() {
				// TODO Auto-generated method stub
				return account.getAuthorities();
			}
		};

		return account;
	}*/
	@Override
	public UserDetails loadUserByUsername(String inputEmail) throws UsernameNotFoundException {
		Account account = memberMapper.findMemberByEmail(securityUtil.encryptSHA256(inputEmail));

		if (account == null) {
			throw new UsernameNotFoundException(messages.getMessage("BLIND_ERR_MSG_001"));
		}

		// TODO: userIdをHttpSessionに入れる臨時コマンド、後で必ず確認
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		request.getSession().setAttribute("userId", account.getUserId());

		account.setAuthorities(getAuthorities(account.getUserAuth()));

		UserDetails userDetails = new UserDetails() {

			private static final long serialVersionUID = 1L;

			@Override
			public boolean isEnabled() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isCredentialsNonExpired() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isAccountNonLocked() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public boolean isAccountNonExpired() {
				// TODO Auto-generated method stub
				return true;
			}

			@Override
			public String getUsername() {
				// TODO Auto-generated method stub
				return account.getUsername();
			}

			@Override
			public String getPassword() {
				// TODO Auto-generated method stub
				return account.getPassword();
			}

			@Override
			public Collection getAuthorities() {
				// TODO Auto-generated method stub
				return account.getAuthorities();
			}
		};
		return account;
	}

	public int registNewMember(Account account) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("password", passwordEncoder.encode(account.getPassword()));
		paramMap.put("username", securityUtil.encryptSHA256(account.getUserEmail()));
		paramMap.put("userNickname", account.getUserNickname());
		paramMap.put("auth", account.getUserAuth());

		return memberMapper.registNewMember(paramMap);
	}

	public boolean checkPassword(String inputPassword, String targetPassword) {
		return passwordEncoder.matches(inputPassword, targetPassword);
	}

	private Collection<GrantedAuthority> getAuthorities(String userEmail) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority(userEmail));

		return authorities;
	}
}