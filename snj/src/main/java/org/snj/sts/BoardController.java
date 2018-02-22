package org.snj.sts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.snj.domain.BoardVO;
import org.snj.domain.CodeVO;
import org.snj.domain.PageMaker;
import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.service.BoardService;
import org.snj.service.CodeService;
import org.snj.service.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpServletRequest request,
			HttpSession session)
			throws Exception {
		Object obj = session.getAttribute("login");
		// 로그인 한경우 회원등급을 가져온다, 운영자와 회원인 경우 보여지는 버튼이 다르게 하기위해
		if (obj != null) {
			UserVO vo = (UserVO) obj;
			String grade = userService.getUserGrade(vo.getU_id());
			model.addAttribute("grade", grade);
		}
		logger.info(cri.toString());
		// 게시판 목록페이지를 하나로만 하여 카테고리에 따라 게시판 목록 다르게 출력하기 위해서
		String category = request.getParameter("category");
		cri.setCategory(category);
		List<BoardVO> list = service.list(cri);
		List<Map<String, String>> liveList = service.liveList(cri);
		model.addAttribute("list", list);
		model.addAttribute("liveList", liveList);
		
		//페이지 처리 부분
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/board/list";
	}
	//상세 읽기
	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model,
			HttpServletRequest request) throws Exception {
		System.out.println("=========================");
		System.out.println(cri);
		System.out.println("=========================");
		model.addAttribute(service.read(bno));
	}
	// 글 삭제
	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, String writer, SearchCriteria cri, 
			RedirectAttributes rttr)
			throws Exception {
		Map<String, Comparable> paramMap = new HashMap<String, Comparable>();
		paramMap.put("bno", bno);
		paramMap.put("writer", writer);
		service.remove(paramMap);
		//삭제후 페이징 처리
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("category", cri.getCategory());
		rttr.addFlashAttribute("msg", "remove_success");

		return "redirect:/board/list";
	}
	//글 수정페이지로 이동.
	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modifyPagingGET(int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		model.addAttribute(service.read(bno));
		List<CodeVO> dsCode1 = null;
		Map<String, String> codeParam = new HashMap<String, String>();
		// 게시판 카테고리 목록
		codeParam.put("commCd", "CODE0101");
		dsCode1 = codeService.retrieveCodeList(codeParam);

		model.addAttribute("dsCode1", dsCode1);
	}
	// 글 수정.
	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPagingPOST(BoardVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		logger.info(cri.toString());
		service.modify(vo);
		//페이징 처리 
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("category", cri.getCategory());
		rttr.addFlashAttribute("msg", "modify_success");

		logger.info(rttr.toString());

		return "redirect:/board/list";
	}
	// 글 등록 페이지로 이동.
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registGET(Model model, HttpServletRequest request) throws Exception {

		logger.info("regist get ...........");
		String category = request.getParameter("category");
		System.out.println("카테고리명: " + category);
		List<CodeVO> dsCode1 = null;
		Map<String, String> codeParam = new HashMap<String, String>();

		codeParam.put("commCd", "CODE0101");
		dsCode1 = codeService.retrieveCodeList(codeParam);
		// System.out.println(dsCode1);
		model.addAttribute("dsCode1", dsCode1);
		model.addAttribute("category", category);
	}
	// 글 등록.
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO vo, String writer, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {

		logger.info("regist post ...........");
		logger.info(vo.toString());
		String category = request.getParameter("category");
		System.out.println(category);
		//동영상 게시판인 경우 동영상주소만 분리해서 데이터베이스에 저장.
		if (category.equals("M")) {
			String content = vo.getContent();
			// System.out.println("content: "+content);
			int startSrc = (content.indexOf("/embed/")) + 7;
			content = content.substring(startSrc, startSrc + 11);
			// System.out.println("content: "+content);
			vo.setThumb(content);
		}

		Map param = new HashMap();
		param.put("board", vo);
		param.put("u_id", writer);
		service.regist(param);

		rttr.addFlashAttribute("msg", "Register_Success");
		String redirect = "redirect:/board/list?category=" + category;

		return redirect;
	}

	@RequestMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno") Integer bno) throws Exception {
		return service.getAttach(bno);
	}

}
