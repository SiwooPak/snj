package org.snj.sts;

import org.snj.domain.PageMaker;
import org.snj.domain.ReplyVO;
import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.domain.BoardVO;
import org.snj.domain.GuestBookVO;
import org.snj.service.GuestBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/guestBooks/*")
public class GuestBookController {

	private static final Logger logger = LoggerFactory.getLogger(GuestBookController.class);

	@Autowired
	private GuestBookService service;

	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView list(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());
		ModelAndView mov = new ModelAndView("guestBook/list");

		cri.setPerPageNum(5);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listSearchCount(cri));
		mov.addObject("list", service.listSearchCriteria(cri));
		mov.addObject("pageMaker", pageMaker);

		return mov;
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String register(GuestBookVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("GuestBook regist post ...........");

		if (vo.getWriter() == session.getId()) {
			service.registerMember(vo);
		} else {
			service.registerGuest(vo);
		}

		return "redirect:/guestBooks/";
	}

	@RequestMapping(value = "/comments/{gbno}", method = RequestMethod.POST)
	public ResponseEntity<String> commentCreate(@RequestBody GuestBookVO vo, @PathVariable("gbno") int gbno,
			HttpSession session) {

		ResponseEntity<String> entity = null;
		Map paramMap = new HashMap();
		paramMap.put("gbno", gbno);
		paramMap.put("vo", vo);
		System.out.println(gbno);
		try {
			if (vo.getWriter() == session.getId()) {
				service.commentMember(paramMap);
			} else {
				service.commentGuest(paramMap);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/comments/{gbno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@RequestBody GuestBookVO vo, @PathVariable("gbno") Integer gbno, 
			HttpSession session) {
		ResponseEntity<String> entity = null;
		try {
			if(session.getId() != null) {
				service.deleteGB(gbno);
			}else {
				Map paramMap = new HashMap();
				paramMap.put("gbno", gbno);
				paramMap.put("pass", vo.getPass());
				service.deleteGB(paramMap);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/comments/{gbno}", method = RequestMethod.PUT)
	public ResponseEntity<String> commentUpdate(@RequestBody GuestBookVO vo, @PathVariable("gbno") int gbno,HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		String content = vo.getContent();
		String pass = vo.getPass();
		System.out.println("content: "+content+", pass: "+pass);
		Map paramMap = new HashMap();
		paramMap.put("gbno", gbno);
		paramMap.put("content", content);
		paramMap.put("pass", pass);
		
		vo = service.commentRead(gbno);
		try {
			if (session.getId() != null) {
				service.updateCommentMember(paramMap);
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				if(service.passCheck(paramMap)) {
					service.updateCommentGuest(paramMap);
					entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
