package org.zerock.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.domain.ReplyPaging;


//import org.apache.ibatis.annotations.Select;

public interface ReplyMapper {
	public List<ReplyVO> getListWithPaging(ReplyPaging paging); //목록
	//public List<ReplyVO> getListWithPaging(Criteria cri); //페이징된 목록처리
	//public int getTotal(Criteria cnt); // 전체 게시글 값 구하기
	public void insert(ReplyVO reply); //등록
	//public void insertSelectKey(BoardVO board); //등록2
	public ReplyVO read(Long rno); //조회
	public int update(ReplyVO reply); //수정 (몇 개의 데이터가 수정되었는지 출력)
	public int delete(Long rno); // 삭제 (정상출력 시 양수 출력)
}
