package org.zerock.service;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.*;

@Log4j // 오류 뜰 경우 maven dependency에서 활성화돼있는지 왁인, 안 돼있으면 pom.xml에서 runtime 주석처리
@AllArgsConstructor // 모든 파라미터를 이용하는 생성자를 만듦. 
@Service("boardService") // 비지니스 영역을 담당하는 객체임을 표시
public class BoardServiceImpl implements BoardService {
	
		@Setter(onMethod_=@Autowired) // 두 개의 매퍼 인터페이스 타입을 주입했으므로 자동주입 대신 setter 메서드 사용
		private BoardAttachMapper aMapper;
	
		@Setter(onMethod_=@Autowired)
		private BoardMapper mapper; // 객체 필요. 스프링 4.3부터는 setter 안 써도 자동생성됨
		
		@Override
		public List<BoardVO> getList(Criteria cri) { // 리스트
			log.info("getListWithPaging : " + cri);
			return mapper.getListWithPaging(cri);
		}
		
		@Transactional
		@Override
		public void register(BoardVO board) { // 등록
			log.info("register: " + board);
			mapper.insertSelectKey(board);
			
			if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
				return;
			}
			
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				aMapper.insert(attach);
			});
		}

		@Override
		public BoardVO get(Long bno) { // 조회
			log.info("get: bno " + bno);
			return mapper.read(bno);
		}
		
		@Override
		public List<BoardAttachVO> getAttachList(Long bno) { // 조회
			log.info("get attach: bno " + bno);
			return aMapper.findByBno(bno);
		}

		@Override
		public boolean modify(BoardVO board) { // 수정 (수정 시 1, true)
			log.info("modify: " + board);
			aMapper.deleteAll(board.getBno()); // DB에서 첨부파일 다 지우기
			boolean modifyResult = mapper.update(board) == 1; // 게시글 수정
			if (modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) { //게시글 수정한 게 있고 추가할 첨부파일이 있다면
				board.getAttachList().forEach(attach-> { // 첨부파일 하나씩 BNO 설정해서 INSERT
					attach.setBno(board.getBno());
					aMapper.insert(attach);
				});
			}
			return modifyResult; // 게시글 수정 결과를 리턴
		}

		@Override
		public boolean remove(Long bno) {  // 삭제 (삭제 시 1, true)
			log.info("remove: bno " + bno);
			aMapper.deleteAll(bno); // 자식 먼저 삭제 후
			return mapper.delete(bno) == 1; // 부모 삭제
		}

		@Override
		public int getTotal(Criteria cri) {
			log.info("get total :  " + cri);
			return mapper.getTotal(cri);
		}

		@Override
		public int getReplyTotal(Long bno) {
			log.info("get total replies of :  " + bno);
			return mapper.getReplyTotal(bno);
		}



}
