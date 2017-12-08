package org.snj.sts;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String message() {
		return "/message/main";
	}

}
