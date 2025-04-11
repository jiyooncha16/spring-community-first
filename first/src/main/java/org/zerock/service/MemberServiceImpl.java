package org.zerock.service;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AdminVO;
import org.zerock.domain.AgeVO;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.DurationVO;
import org.zerock.domain.GenderVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.SearchBoardVO;
import org.zerock.domain.SearchReplyVO;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.*;

@Log4j // 오류 뜰 경우 maven dependency에서 활성화돼있는지 왁인, 안 돼있으면 pom.xml에서 runtime 주석처리
@AllArgsConstructor // 모든 파라미터를 이용하는 생성자를 만듦. 
@Service("memberService") // 비지니스 영역을 담당하는 객체임을 표시
public class MemberServiceImpl implements MemberService {
	
		@Setter(onMethod_=@Autowired)
		private MemberMapper mapper; // 객체 필요. 스프링 4.3부터는 setter 안 써도 자동생성됨
		

		@Override
		public void join(MemberVO vo) {
			log.info("Service : joining ...");
			mapper.join(vo);
			mapper.joinAuth(vo);
		}

		@Override
		public int checkid(String memberid) {
			String result = mapper.checkid(memberid);
			log.info("result : " + result);
			if (result != null) {
				return 1;
			} else {
				return 0;
			}
		}

		@Override
		public String searchid(String name) {
			String result = mapper.searchid(name);
			log.info("result : " + result);
			return result;
		}

		@Override
		public MemberVO read(String memberid) {
			MemberVO vo = mapper.read(memberid);
			return vo;
		}

		@Override
		public void profileEdit(MemberVO member) {
			mapper.profileEdit(member);
		}

		@Override
		public List<AdminVO> allMember() {
			log.info("allMember...");
			List<AdminVO> vo= mapper.allMember();
			return vo;
		}

		@Override
		public int countMember() {
			log.info("counting members...");
			int result = mapper.countMember();
			return result;
		}
		
		@Override
		public int countBoard() {
			log.info("counting boards...");
			int result = mapper.countBoard();
			return result;
		}
		
		@Override
		public int countReply() {
			log.info("counting replies...");
			int result = mapper.countReply();
			return result;
		}
		
		@Override
		public List<GenderVO> countGender() {
			log.info("gender counting...");
			List<GenderVO> vo= mapper.countGender();
			return vo;
		}

		@Override
		public List<AgeVO> countAge() {
			log.info("age counting...");
			List<AgeVO> vo= mapper.countAge();
			return vo;
		}

		@Override
		public List<DurationVO> searchDuration(String startDate, String endDate) {
			log.info("search duration...");
			List<DurationVO> vo= mapper.searchDuration(startDate, endDate);
			return vo;
		}

		@Override
		public List<SearchBoardVO> searchBoard(String memberid) {
			log.info("search board by memberid...");
			List<SearchBoardVO> vo= mapper.searchBoard(memberid);
			return vo;
		}

		@Override
		public List<SearchReplyVO> searchReply(String memberid) {
			log.info("search reply by memberid...");
			List<SearchReplyVO> vo= mapper.searchReply(memberid);
			return vo;
		}

		@Override
		public void passwordEdit(String memberid, String memberpw) {
			mapper.passwordEdit(memberid, memberpw);
			return;
		}
}
