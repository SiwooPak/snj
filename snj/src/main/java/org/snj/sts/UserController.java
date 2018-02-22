package org.snj.sts;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;
import com.github.scribejava.core.model.OAuth2AccessToken;

import org.snj.domain.UserVO;
import org.snj.domain.LoginDTO;
import org.snj.domain.PageMaker;
import org.snj.domain.SearchCriteria;
import org.snj.service.UserService;
import org.snj.util.NaverLoginBO;

@Controller
@RequestMapping("/user/*")
public class UserController {

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@Autowired
	private UserService service;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@RequestMapping(value = "/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverLogin(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		System.out.println("네이버:" + naverAuthUrl);

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "/user/naverLogin";
	}

	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		model.addAttribute("result", apiResult);

		/* 네이버 로그인 성공 페이지 View 호출 */
		return "/user/naverSuccess";
	}
 	//회원정보 및 회원목록 페이지 이동시 비밀번호 확인 페이지로 이동.
	@RequestMapping(value = "/passChk", method = RequestMethod.GET)
	public String passChk() {
		return "/user/passChk";
	}
	
	//패스워드 확인.
	@RequestMapping(value = "/passChkProc", method = RequestMethod.POST)
	public void passChk(String upw, HttpSession session, Model model) throws Exception {
		String grade = "";
		//세션에 있는 로그인 정보를 object에 담아둔다.
		Object obj = session.getAttribute("login");
		//로그인 했을 시
		if (obj != null) {
			//UserVO타입으로 형변환.
			UserVO vo = (UserVO) obj;
			//ID값과 패스워드 값을 담아둘 Map생성.
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("id", vo.getU_id());
			paramMap.put("pass", upw);
			//패스워드 체크 후 등급을 가져와서 회원 등급에 따라 회원정보 혹은 회원목록 페이지로 이동.
			if (service.passCheck(paramMap)) {
				grade = service.getUserGrade(vo.getU_id());
				model.addAttribute("grade", grade);
			} 
		}
	}
	//운영자인 경우 회원목록 페이지로.
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String userList(@ModelAttribute("cri") SearchCriteria cri, Model model, HttpSession session)
			throws Exception {

		logger.info(cri.toString());

		List<UserVO> list = service.userList(cri);

		model.addAttribute("list", list);
		//페이징 처리 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		return "/user/members";

	}
	
	//회원 정보수정 
	@RequestMapping(value = "/user/updateUser", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateUser(@ModelAttribute UserVO vo, HttpSession session, 
			Model model, RedirectAttributes rttr) throws Exception {
		Object obj = session.getAttribute("login");
		UserVO uid = (UserVO) obj;
		String id = uid.getU_id();
		String flag = vo.getUname();
		System.out.println("이름: " + flag);
		UserVO user = service.retrieveUser(id);
		//flag 값이 없을시 유저 정보를 가져와서 모델의user 정보를 담아서 memberInfo페이지에 전달.
		if (flag == null) {
			model.addAttribute("user", user);
			return "/user/memberInfo";
		} else {
		//회원 정보 수정 후의 다시 회원정보 페이지로 이동.
			service.updateUser(vo);
			return "redirect:/user/updateUser";
		}
	}
	
	//회원 등업
	@RequestMapping(value = "/{u_id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	@ResponseBody
	public ResponseEntity<String> gradeUp(@PathVariable("u_id") String u_id) {
		ResponseEntity<String> entity = null;
		try {
			//그 회원아이디를 가져와서 등업. 
			service.gradeUp(u_id);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//회원 추방
	@RequestMapping(value = "/{u_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<String> userBye(@PathVariable("u_id") String u_id, String pass) {
		ResponseEntity<String> entity = null;
		try {
			//추방할 회원정보 삭제 
			service.userBye(u_id);
			//메세지 전달.
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//로그인 페이지로 이동.
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGET() {
		return new ModelAndView("/user/login");
	}
	//로그인 시 모델에 유저 정보와 로그인 정보 기억을 체크하면 일주일동안 로그인 유지.
	@RequestMapping(value = "/loginProc", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		UserVO vo = service.login(dto);

		model.addAttribute("userVO", vo);

		if (dto.isUseCookie()) {
			// 쿠키 유지기간(일주일)
			int amount = 60 * 60 * 24 * 2;

			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

			service.keepLogin(vo.getU_id(), session.getId(), sessionLimit);
		}
	}
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		logger.info("logout.................................1");
		//로그인정보를 Object에 담는다.
		Object obj = session.getAttribute("login");
		//로그인 했을 시.
		if (obj != null) {
			UserVO vo = (UserVO) obj;
			logger.info("logout.................................2");
			//세션에 로그인 정보 제거
			session.removeAttribute("login");
			session.invalidate();

			logger.info("logout.................................3");
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			//쿠키 정보가 있을시.
			if (loginCookie != null) {
				logger.info("logout.................................4");
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getU_id(), session.getId(), new Date());
			}
		}

		return "redirect:/";
	}
	
	//아이디 동일 여부 확인 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> idCheck(HttpServletRequest request) throws Exception {
		//입력받은 id 값을 받아서 그 id가 데이터베이스 있는지 없는지 확인.
		String id = request.getParameter("id");
		UserVO vo = service.retrieveUser(id);
		//기본 메시지
		String checkMsg = "<font color='green' size='3px;'><i class='fa fa-check'>&nbsp;사용가능한 아이디 입니다.</i></font>@true";
		//데이터 베이스에 있을 겨우
		if (vo != null) {
			checkMsg = "<font color='red' size='3px;'><i class='fa fa-times'>&nbsp;동일한 아이디가 존재합니다.</i></font>@false";
		}
		//id를 입력안할시
		if (id == null || id.equals("")) {
			checkMsg = "<font color='red' size='3px;'><i class='fa fa-times'>&nbsp;아이디를 입력하세요.</i></font>@false";
		}
		//결과값 전달.
		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> resultMsg = new ResponseEntity<String>(checkMsg, resHeader, HttpStatus.OK);

		return resultMsg;
	}
	//이메일의 동일 여부 확인.
	@RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> emailCheck(HttpServletRequest request) throws Exception {
		String email = request.getParameter("email");
		UserVO vo = service.retrieveMail(email);
		String checkMsg = "<font color='green' size='3px;'><i class='fa fa-check'>&nbsp;사용가능한 이메일 입니다.</i></font>@true";

		if (vo != null) {
			checkMsg = "<font color='red' size='3px;'><i class='fa fa-times'>&nbsp;동일한 이메일이 존재합니다.</i></font>@false";
		}

		if (email == null || email.equals("")) {
			checkMsg = "<font color='red' size='3px;'><i class='fa fa-times'>&nbsp;이메일을 입력하세요.</i></font>@false";
		}

		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> message2 = new ResponseEntity<String>(checkMsg, resHeader, HttpStatus.OK);

		return message2;
	}
	//회원가입 페이지로 이동.
	@RequestMapping(value = "/createUser", method = RequestMethod.GET)
	public String createUser() {
		return "/user/create";
	}
	//회원가입 후 로그인 페이지로 이동
	@RequestMapping(value = "/createUser", method = RequestMethod.POST)
	public ModelAndView createUser(@ModelAttribute("vo") UserVO vo) throws Exception {
		ModelAndView mv = new ModelAndView();
		//vo.toString();
		service.createUser(vo);
		mv.setViewName("/user/login");

		return mv;
	}
	//회원사진 업로드시.
	@RequestMapping(value = "/saveFile", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveFile(HttpServletRequest request) throws IOException {
		String imageFolder = request.getParameter("imageFolder");
		String imgFolder = imageFolder;
		@SuppressWarnings("deprecation")
		String realFolder = request.getRealPath("/") + imgFolder;

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("imageFile");
		System.out.println(file.toString());
		// 한글 파일명 깨짐 방지.
		String filename = file.getOriginalFilename();
		System.out.println("파일 이름: " + filename);
		File ufile = new File(realFolder + file.getOriginalFilename());
		file.transferTo((ufile));
		// makeThumbnail(realFolder,file.getOriginalFilename(),);

		return filename;
	}
	
	//id찾기 페이지 이동.
	@RequestMapping(value = "/idFind", method = RequestMethod.GET)
	public String idFind() {
		return "/user/idFind";
	}
	//id찾기 구현. 자신의 이메일 값을 입력시 id값 전달.
	@RequestMapping(value = "/user/retrieveUserId", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, String>> retrieveUserId(HttpServletRequest request) throws Exception {
		String checkMsg = "";
		String email = request.getParameter("email");
		String id = service.retrieveUserId(email);

		Map<String, String> idMap = new HashMap<String, String>();

		if (id == null) {
			checkMsg = "<div class='col-md-5 col-md-offset-2'>" + "<p>ID가 없습니다.</p>" + "</div>";
		} else {
			checkMsg = "<div class='col-md-5 col-md-offset-2'>" + "<p>ID는<font color='red'><strong>" + id
					+ "</strong></font>입니다." + " <a href='./login'>로그인 화면으로</a>|<a href='./pwFind'>PW찾기</a></p>"
					+ "</div>";
		}

		idMap.put("checkMsg", checkMsg);

		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<Map<String, String>> resultMsg = new ResponseEntity<Map<String, String>>(idMap, resHeader,
				HttpStatus.OK);
		return resultMsg;
	}

	// 패스워드 찾기 페이지로 이동.
	@RequestMapping(value = "/pwFind", method = RequestMethod.GET)
	public String pwFind() {
		return "/user/pwFind";
	}
	// id, email 값을 가지고 패스워드를 찾는다.
	@RequestMapping(value = "/retrieveUserPw", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, String>> retrieveUserPw(HttpServletRequest request) throws Exception {
		String checkMsg = "";
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String pw = service.retrieveUserPw(id, email);

		Map<String, String> idMap = new HashMap<String, String>();

		if (pw == null) {
			checkMsg = "<div class='col-md-5 col-md-offset-2'>" + "<p>등록된 Email과ID가 아닙니다. 다시 입력하세요.</p>" + "</div>";
		} else {
			checkMsg = "<div class='col-md-4 col-md-offset-2'>" + "<p>패스워드는&nbsp;<font color='blue'><strong>" + pw
					+ "</strong></font>입니다." + " <a href='./login'>로그인 화면으로</a></p>" + "</div>";
		}

		idMap.put("checkMsg", checkMsg);

		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<Map<String, String>> resultMsg = new ResponseEntity<Map<String, String>>(idMap, resHeader,
				HttpStatus.OK);
		return resultMsg;
	}
}
