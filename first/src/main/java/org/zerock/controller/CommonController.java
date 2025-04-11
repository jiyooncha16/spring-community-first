package org.zerock.controller;

import java.security.Principal;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AuthVO;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.DurationVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.SearchBoardVO;
import org.zerock.domain.SearchByIdDTO;
import org.zerock.domain.SearchReplyVO;
import org.zerock.security.domain.CustomUser;
import org.zerock.service.BoardService;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Log4j
//@RequestMapping("/board/*")
@AllArgsConstructor // BoardSercive에 의존적이므로 생성자 만들어 자동 주입
@Controller // 스프링의 빈으로 인식
public class CommonController {
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {

		log.info("access Denied : " + auth);

		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/loginPage")
	public void loginPage(String error, String logout, Model model, HttpServletRequest request) {
		log.info("login page ......");
		log.info("error: " + error);
		log.info("logout: " + logout);

		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
		 String uri = request.getHeader("Referer");
		    if (uri != null && !uri.contains("/login")) {
		        request.getSession().setAttribute("prevPage", uri);
		    }

	}
	
	@GetMapping("/logoutPage")
	public void logoutPage() {
		log.info("logout page ......");
	}
	
	@PostMapping("/logoutPage")
	public void logoutPagePost() {
		log.info("logout post request......");
	}
	
	@GetMapping("/join")
	public void joinPage() {
		log.info("join page ......");
	}
	
	@PostMapping("/join")
	public String joinPagePost(MemberVO member) {
		log.info("join post request ......");
		log.info(member);
		member.setEnabled(true);
		member.setAuthList(List.of(new AuthVO(member.getMemberid(), "ROLE_USER")));
		
		String encodedPassword = passwordEncoder.encode(member.getMemberpw());
		member.setMemberpw(encodedPassword);
		
		log.info(member);
		
		service.join(member);
		
		return "/welcome";
	}
	
	@GetMapping("/welcome")
	public void welcomePage() {
		log.info("join success! welcome page ......");
	}
	
	@PostMapping("/checkid")
	@ResponseBody // result가 1인 경우 1.jsp 를 찾으려 하기 때문에, 이 값 그대로 http 응답 본문에 보내겠다는 뜻
	public int checkid(String memberid) {
		log.info("checking id ...... ");
		int result = service.checkid(memberid);
		log.info(result);
		return result; // 1이면 중복 있음, 0이면 없음
	}
	
	@GetMapping("/searchid")
	public void searchidPage() {
		log.info("search id request ......");
	}
	
	
	@PostMapping("/searchid")
	@ResponseBody // result가 1인 경우 1.jsp 를 찾으려 하기 때문에, 이 값 그대로 http 응답 본문에 보내겠다는 뜻
	public String searchidPost(String name) {
		log.info("searching id ...... ");
		String result = service.searchid(name);
		log.info(result);
		return result; // 1이면 중복 있음, 0이면 없음
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/profile")
	public void profilePage(Principal principal, Model model) {
		log.info("profile page ......");
		String memberid = principal.getName();
		MemberVO member = service.read(memberid);
		log.info("member : " + member);
		model.addAttribute("user", member);
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/profileEdit")
	public void profileEditPage(Principal principal, Model model) {
		log.info("profile page ......");
		String memberid = principal.getName();
		MemberVO member = service.read(memberid);
		log.info("member : " + member);
		model.addAttribute("user", member);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/profileEdit")
	public String profileEditPost(Principal principal, MemberVO member, Model model) {
		log.info("profile edit request......");
		log.info("member vo : " + member);
		
		String memberid = principal.getName();
		
		if (member.getMemberpw() != null) {
			String encodedPassword = passwordEncoder.encode(member.getMemberpw());
			member.setMemberpw(encodedPassword);
		}
		
		service.profileEdit(member);
		return "redirect:/profile";
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/passwordEdit")
	public void passwordEditPage() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/passwordEdit")
	public String passwordEditPost(Principal principal, String memberpw, Model model, RedirectAttributes rttr) {
		log.info("password edit request......");
		String memberid = principal.getName();
		log.info("password edit - id : " + memberid);
		log.info("password edit - pw : " + memberpw);
		
		if (memberpw == null) {
			log.info("error... password is null");
			return "redirect:/passwordEdit";
		}
		
		String encodedpw = passwordEncoder.encode(memberpw);
		log.info("encoded password : " + encodedpw);
		service.passwordEdit(memberid, encodedpw);
		
		rttr.addFlashAttribute("result", 1);
		
		return "redirect:/profile";
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping("/admin/main")
	public void adminPage(Model model) {
		log.info("admin page request ......");
		model.addAttribute("user", service.allMember());
		model.addAttribute("memberCnt", service.countMember());
		model.addAttribute("boardCnt", service.countBoard());
		model.addAttribute("replyCnt", service.countReply());
		model.addAttribute("gender", service.countGender());
		model.addAttribute("age", service.countAge());
		//model.addAttribute("board", service.allBoard());
		//model.addAttribute("reply", service.allReply());
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping("/admin/member")
	public void memberPage(Model model) {
		log.info("member page request ......");
		model.addAttribute("user", service.allMember());
		model.addAttribute("memberCnt", service.countMember());
		model.addAttribute("boardCnt", service.countBoard());
		model.addAttribute("replyCnt", service.countReply());
		//model.addAttribute("board", service.allBoard());
		//model.addAttribute("reply", service.allReply());
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	@ResponseBody
	@PostMapping("/admin/searchDuration")
	public List<DurationVO> searchDurationPost(Model model,
			@RequestParam("startDate")String startDate, 
			@RequestParam("endDate")String endDate) {
		log.info("search duration request ......");
		log.info(service.searchDuration(startDate, endDate));
		List<DurationVO> result = service.searchDuration(startDate, endDate);
		return result;
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	@ResponseBody
	@PostMapping("/admin/searchById")
	public SearchByIdDTO searchById(@RequestParam("memberid") String memberid) {
		log.info("search by id request ...... : " + memberid);
		List<SearchBoardVO> boards = service.searchBoard(memberid);
	    List<SearchReplyVO> replies = service.searchReply(memberid);
	    log.info("boards: " + boards);
	    log.info("replies: " + replies);
	    
	    return new SearchByIdDTO(boards, replies);
	}

	/*
	@PostMapping("/loginSuccess")
	public String loginSuceess(MemberVO vo) {
		log.info("login success ......");
	    log.info("ID: " + vo.getMemberid()); 
	    log.info("Password: " + vo.getMemberpw());
		return "redirect:/board/list";
	}
	
	@PostMapping("/logoutSuccess")
	public String logoutSuceess(MemberVO vo) {
		log.info("logout success ......");
		return "redirect:/board/list";
	}
	*/
}