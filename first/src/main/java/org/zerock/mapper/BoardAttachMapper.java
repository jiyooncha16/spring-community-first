package org.zerock.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


//import org.apache.ibatis.annotations.Select;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public void deleteAll(Long bno);
	public List<BoardAttachVO> findByBno(Long bno);
}
