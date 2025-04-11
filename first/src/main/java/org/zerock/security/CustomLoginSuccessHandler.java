package org.zerock.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		
		// 이전 페이지 url을 referer로 request헤더에 담고있음
		// referer 헤더값을 session에 저장,그 url로 리다이렉트
		// 로그인 성공 후 원래 페이지로 리다이렉트하는 로직
		// 세션에서 저장된 redirectUrl 가져오기
	    //String redirectUrl = (String) request.getSession().getAttribute("prevPage");
		
		System.out.println("Login Success!");

	    HttpSession session = request.getSession();
	    String redirectUrl = (String) session.getAttribute("prevPage");
	    
	    System.out.println("prevPage: " + redirectUrl);

	    // redirectUrl이 null이 아니고, 로그인 페이지가 아닌 경우 그 URL로 리다이렉트
	    if (redirectUrl != null && !redirectUrl.contains("/login") && !redirectUrl.contains("/logout")) {
	    	System.out.println("Redirecting to: " + redirectUrl);
	        response.sendRedirect(redirectUrl);

	    } else {
	        // 기본 페이지로 리다이렉트
	    	System.out.println("Redirecting to default page");
	        response.sendRedirect("/board/list");
	    }
	}
		
/*
		log.warn("Login Success");
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});

		log.warn("ROLE NAMES: " + roleNames);
		if (roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		}

		if (roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/sample/member");
			return;
		}

		response.sendRedirect("/");
	} */
}


