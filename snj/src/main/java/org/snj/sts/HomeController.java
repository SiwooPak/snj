package org.snj.sts;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.snj.domain.UserVO;
import org.snj.service.UserService;
import org.snj.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session,HttpServletRequest request) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		Object obj = session.getAttribute("login");
		if (obj != null) {
			UserVO vo = (UserVO) obj;
			String grade = userService.getUserGrade(vo.getU_id());
			model.addAttribute("grade", grade);
		}
		
		List<Map<String,String>> categoryList = boardService.categoryList();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat now = new SimpleDateFormat("yyyy:MM:dd-hh:mm:ss");
		
		String formattedDate = now.format(cal.getTime());
		int min = cal.get(Calendar.MINUTE);
		
		model.addAttribute("now", min);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("serverTime", formattedDate);
	
		return "home";
	}
	
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public String mailSending(HttpServletRequest request, RedirectAttributes rttr) {

		String setfrom = "siwoo1620@gmail.com";
		String mail = request.getParameter("email"); // 받는 사람 이메일
		String name = request.getParameter("name"); // 제목
		String comment = request.getParameter("comment"); // 내용
	    try {
	    		MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(mail); // 받는사람 이메일
			messageHelper.setSubject(name); // 메일제목은 생략이 가능하다
			messageHelper.setText(comment); // 메일 내용

			mailSender.send(message);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    rttr.addFlashAttribute("msg", "SUCCESS");
	    return "redirect:/";
	}

}