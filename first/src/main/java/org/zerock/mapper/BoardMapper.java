package org.zerock.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


//import org.apache.ibatis.annotations.Select;

public interface BoardMapper {
	public List<BoardVO> getList(); //목록
	public List<BoardVO> getListWithPaging(Criteria cri); //페이징된 목록처리
	public int getTotal(Criteria cnt); // 전체 게시글 수 구하기
	public int getReplyTotal(Long bno); // 게시글 댓글 수 구하기
	public void insert(BoardVO board); //등록
	public void insertSelectKey(BoardVO board); //등록2
	public BoardVO read(Long bno); //조회
	public int update(BoardVO board); //수정 (몇 개의 데이터가 수정되었는지 출력)
	public int delete(Long bno); // 삭제 (정상출력 시 양수 출력)
}
