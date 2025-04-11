package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ReplyVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ReplyPaging;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Log4j
@RequestMapping("/reply/*")
@AllArgsConstructor // ReplySercive에 의존적이므로 생성자 만들어 자동 주입
@Controller // 스프링의 빈으로 인식
public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	
	@GetMapping("/list")
	@ResponseBody
	public List<ReplyVO> list(Model model, @RequestParam("bno")Long bno, @RequestParam("page") int page) { // ajax에 반환해야 하므로 json데이터로 반환해야 함. 고로 responseBody 사용해야~
		log.info("replies for bno : " + bno);
		log.info("replies page : " + page);
		
		ReplyPaging paging = new ReplyPaging();
		paging.setPage(page);
		paging.setBno(bno);
		
		log.info("paging parameters : " + paging);
		
		List<ReplyVO> replies = service.getList(paging);
		
		return replies;
	}

	@PostMapping("/register") //등록버튼 누를 때
	//@PreAuthorize("isAuthenticated()")
	public String register(ReplyVO reply, @RequestParam("bno")Long bno) {
		
		log.info("reply : " + reply.getReply());
		log.info("replyer : " + reply.getReplyer());
		log.info("register reply of bno: " + reply.getBno());
		try {
	        service.register(reply);
	    } catch (Exception e) {
	        log.error("Error - controller", e);
	    }
		return "redirect:/board/get?bno="+bno;
	}
	

	@PostMapping("/modify")
	//@PreAuthorize("authentication != null and authentication.name == @replyService.get(#rno).replyer")
	@PreAuthorize("isAuthenticated()")
	public String modify(@RequestParam("bno")Long bno, @RequestParam("rno")Long rno, @RequestParam("newReply")String newReply, RedirectAttributes rttr) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		log.info("modify reply : " + rno + newReply);
		ReplyVO reply = new ReplyVO();
		reply.setRno(rno);
		reply.setReply(newReply);  // reply만 세팅
		if (service.modify(reply)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/get?bno=" + bno;
	}
	
	@GetMapping("/remove")
	@PreAuthorize("authentication != null and authentication.name == @replyService.get(#rno).replyer")
	public String remove(@RequestParam("bno")Long bno, @RequestParam("rno") Long rno, RedirectAttributes rttr) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		log.info("remove: rno "+rno);
		if (service.remove(rno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/get?bno="+bno;
	}

	
}