package org.zerock.service;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPaging;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.*;

@Log4j // 오류 뜰 경우 maven dependency에서 활성화돼있는지 왁인, 안 돼있으면 pom.xml에서 runtime 주석처리
@AllArgsConstructor // 모든 파라미터를 이용하는 생성자를 만듦. 
@Service("replyService") // 비지니스 영역을 담당하는 객체임을 표시
public class ReplyServiceImpl implements ReplyService {
	
		//@Setter(onMethod_=@Autowired) // 두 개의 매퍼 인터페이스 타입을 주입했으므로 자동주입 대신 setter 메서드 사용
		//private BoardAttachMapper attachMapper;
	
		@Setter(onMethod_=@Autowired)
		private BoardMapper bMapper;
		private ReplyMapper rMapper;
		
		@Override
		public List<ReplyVO> getList(ReplyPaging paging) { //목록
			log.info("getList..............");
			return rMapper.getListWithPaging(paging);
		}
		/*
		@Override
		public List<ReplyVO> getList(Criteria cri) {
			log.info("getListWithPaging : " + cri);
			return rMapper.getListWithPaging(cri);
		}
		
		*/
		@Override
		public void register(ReplyVO reply) {
		    log.info("register reply: " + reply);
		    try {
		        rMapper.insert(reply);
		    } catch (Exception e) {
		        log.error("Error occurred - service", e);
		    }
		}
		@Override
		public boolean modify(ReplyVO reply) {
			log.info("modify rno with reply: " + reply.getRno() + ',' + reply.getReply());
			return rMapper.update(reply) == 1;
		}

		@Override
		public boolean remove(Long rno) {  // 삭제 (삭제 시 1, true)
			log.info("remove: rno " + rno);
			return rMapper.delete(rno) == 1;
		}
		
		@Override
		public ReplyVO get(Long rno) { // 조회
			log.info("get: rno " + rno);
			return rMapper.read(rno);
		}

/*
		@Override
		public int getTotal(Criteria cri) {
			log.info("get total :  " + cri);
			return rMapper.getTotal(cri);
		}
*/


}
