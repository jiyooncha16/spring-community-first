package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Log4j
@RequestMapping("/board/*") // /board/로 시작하는 모든 처리를 BoardController가 하도록 지정함
@AllArgsConstructor // BoardSercive에 의존적이므로 생성자 만들어 자동 주입
@Controller // 스프링의 빈으로 인식
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		int total = service.getTotal(cri);
		log.info("list : " + cri);
		log.info("total : " + total);
		log.info("keyword : " + cri.getKeyword());
		log.info("pageNum : " + cri.getPageNum());
		model.addAttribute("list", service.getList(cri)); // service 쪽의 getList 결과를 담아 전달
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("keyword", cri.getKeyword());
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {}
	
	@PostMapping("/register") //등록버튼 누를 때
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		log.info("register: " + board);
		log.info("register bno: " + board.getBno());
		log.info(board.getAttachList());
		
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach)); //첨부파일 각각을 로그에 찍기
			
		}
		service.register(board);
		rttr.addFlashAttribute("number", board.getBno()); // 데이터를 한 번 전달할 때 사용. (주로 리다이렉트 시 데이터 전달에 쓰임) 나중에 자바스크립트가 받아서 쓴다.
		return "redirect:/board/get?bno=" + board.getBno() + "&page=1";
	}
	
	@GetMapping("/get")
	public String get(Long bno, Model model, RedirectAttributes rttr,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		log.info("get: bno "+bno);
		model.addAttribute("result", service.get(bno));
		model.addAttribute("postNumber", service.get(bno).getBno());
		model.addAttribute("postTitle", service.get(bno).getTitle());
		model.addAttribute("postContent", service.get(bno).getContent());
		model.addAttribute("postWriter", service.get(bno).getWriter());
		

	    return "/board/get";
	}
	
	@GetMapping("/getAttachList")
	@ResponseBody
	public List<BoardAttachVO> getAttachList(@RequestParam("bno") Long bno) {
	    log.info("get attach list: bno " + bno);
	    return service.getAttachList(bno);
	}	
	 
	
	@GetMapping("/modify")
	@PreAuthorize("authentication != null and authentication.name == @boardService.get(#bno).writer")
	public void modify(Long bno, String writer, Model model) {
		log.info("modify: bno "+bno);
		model.addAttribute("result", service.get(bno));
		model.addAttribute("postNumber", service.get(bno).getBno());
		model.addAttribute("postTitle", service.get(bno).getTitle());
		model.addAttribute("postContent", service.get(bno).getContent());
		model.addAttribute("postWriter", service.get(bno).getWriter());
	}
	
	@PostMapping("/modify")
	@PreAuthorize("authentication != null and authentication.name == @boardService.get(#board.bno).writer")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		if (service.modify(board)) { // 수정 결과가 있다면
			rttr.addFlashAttribute("number", board.getBno());
		}

		return "redirect:/board/get?bno=" + board.getBno() + "&page=1";
	}
	
	
	@GetMapping("/remove")
	@PreAuthorize("authentication != null and authentication.name == @boardService.get(#bno).writer")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) { // 나중에 게시물의 목록을 전달해야 하므로 model을 파라미터로.
		log.info("remove: bno "+bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	
	/* 여기부터 붙여놓기만 함
	private void deleteFiles(List<BoardAttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files...................");
		log.info(attachList);
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);
				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		});// end foreachd
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}

}*/

}