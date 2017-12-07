package org.snj.sts;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
 
@Controller
@RequestMapping(value="/chat")
public class ChatController
{
    @RequestMapping(value="/form", method=RequestMethod.GET)
    public String form(){
        return "/chat/chatting";
    }
 
}
