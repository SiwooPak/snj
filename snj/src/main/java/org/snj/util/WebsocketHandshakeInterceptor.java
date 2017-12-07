package org.snj.util;
import java.util.*;
 
import javax.servlet.http.*;

import org.snj.domain.UserVO;
import org.springframework.http.server.*;
import org.springframework.web.socket.*;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
  
public class WebsocketHandshakeInterceptor extends HttpSessionHandshakeInterceptor
{
    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
            ServerHttpResponse response, WebSocketHandler wsHandler,
            Map<String, Object> attributes) throws Exception
    {
        System.out.println("Before Handshake");
        ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
        HttpServletRequest req =  ssreq.getServletRequest();
        HttpSession session = req.getSession();
        Object obj = session.getAttribute("login");
        if(obj != null) {
        		UserVO vo = (UserVO)obj;
        		String id = vo.getUname();
            System.out.println("아이디: "+id);
            attributes.put("userId", id);
        }
 
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
  
    @Override
    public void afterHandshake(ServerHttpRequest request,
            ServerHttpResponse response, WebSocketHandler wsHandler,
            Exception ex)
    {
        System.out.println("After Handshake");
        super.afterHandshake(request, response, wsHandler, ex);
    }
  
}