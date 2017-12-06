package org.snj.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;
import org.snj.domain.UserVO;
import org.snj.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Autowired
	private UserService service;
	
	
	private void saveDest(HttpServletRequest hsr) {
		String uri = hsr.getRequestURI();
		String query = hsr.getQueryString();
		
		if(query == null || query.equals("null")) {
			query="";
		}else {
			query = "?"+query;
		}
		
		if(hsr.getMethod().equals("GET")) {
			logger.info("dest: "+ (uri+query));
			hsr.getSession().setAttribute("dest", uri+query);
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") == null) {
			logger.info("로그인 하십시요!");
			saveDest(request);
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				UserVO vo = service.checkLoginBefore(loginCookie.getValue());
				logger.info("UserVO: "+ vo);
				
				if(vo != null) {
					session.setAttribute("login", vo);
					return true;
				}
			}
			response.sendRedirect("/user/login");
			return false;
		}

		return true;
	}

}
