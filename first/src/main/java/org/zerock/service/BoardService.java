package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService { // 메서드 이름을 현실적이게
	//public List<BoardVO> getList(); // 목록
	public List<BoardVO> getList(Criteria cri); // 페이징 된 목록
	public int getTotal(Criteria cri);
	public int getReplyTotal(Long bno);
	public void register(BoardVO board); // 등록
	public BoardVO get(Long bno); //조회
	public List<BoardAttachVO> getAttachList(Long bno); // 첨부파일 조회
	public boolean modify(BoardVO board); //수정 (몇 개의 데이터가 수정되었는지 출력)
	public boolean remove(Long bno); // 삭제 (정상출력 시 양수 출력)
}
