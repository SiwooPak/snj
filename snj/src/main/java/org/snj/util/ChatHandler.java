package org.snj.util;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.Cookie;

import org.json.simple.*;
import org.json.simple.parser.*;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.util.WebUtils;
 
public class ChatHandler extends TextWebSocketHandler
{
    static List<WebSocketSession> sessions = new ArrayList<>();
    
    public ChatHandler(){
        System.out.println("웹소켓 핸들러 생성됨");
    }
     
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("afterConnectionEstablished()");
        sessions.add(session);
        informNewUser();
    }
 
    @SuppressWarnings("unchecked")
	@Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println("handleTextMessage()");
        String sender = (String) session.getAttributes().get("userId");
        System.out.println("보내는 사람:"+sender);
        String content = message.getPayload();
        JSONParser jp = new JSONParser();
        JSONObject jo = (JSONObject) jp.parse(content);
        String msg = (String)jo.get("msg");
        msg = sender+":"+msg;
        System.out.println("메시지:"+msg);
        JSONObject jsObj = new JSONObject();
        jsObj.put("msg", msg);
         
        JSONArray ja = (JSONArray)jo.get("receiver");
         
        for(int i=0;i<sessions.size();i++) {
            String uid = (String) sessions.get(i).getAttributes().get("userId");
            for(int k=0;k<ja.size();k++) {
                String recvId = (String) ja.get(k);
                if(recvId.equals(uid)) {
                    sessions.get(i).sendMessage(new TextMessage(jsObj.toJSONString()));
                }
            }
        }
    }
     
    @SuppressWarnings("unchecked")
	private void informNewUser() {
        JSONArray ja = new JSONArray();
        for(int i=0;i<sessions.size();i++) {
            String uid = (String) sessions.get(i).getAttributes().get("userId");
            ja.add(uid);
        }
        JSONObject jo = new JSONObject();
        jo.put("userList", ja);
        String jsonStr = jo.toJSONString();
        try{
            for(int i=0;i<sessions.size();i++) {
                    sessions.get(i).sendMessage(new TextMessage(jsonStr));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
     
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println("afterConnectionClosed()");
        sessions.remove(session);
    }
 
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        System.out.println("handleTransportError()");
    }
     
}