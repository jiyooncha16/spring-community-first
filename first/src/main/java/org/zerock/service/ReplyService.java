package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPaging;
import org.zerock.domain.ReplyVO;

@Service
public interface ReplyService { // 메서드 이름을 현실적이게
	public List<ReplyVO> getList(ReplyPaging paging); // 목록
	//public List<ReplyVO> getList(Criteria cri); // 페이징 된 목록
	//public int getTotal(Criteria cri);
	public void register(ReplyVO reply); // 등록
	public boolean modify(ReplyVO reply); //수정 (몇 개의 데이터가 수정되었는지 출력)
	public boolean remove(Long rno); // 삭제 (정상출력 시 양수 출력)
	public ReplyVO get(Long rno);
}
