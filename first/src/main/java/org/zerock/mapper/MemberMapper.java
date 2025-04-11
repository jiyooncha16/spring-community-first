package org.zerock.mapper;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
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


//import org.apache.ibatis.annotations.Select;

public interface MemberMapper {
	public MemberVO read(String memberid);
	public void join(MemberVO vo);
	public void joinAuth(MemberVO vo);
	public String checkid(String memberid);
	public String searchid(String name);
	public void profileEdit(MemberVO member);
	public List<AdminVO> allMember();
	public int countMember();
	public int countBoard();
	public int countReply();
	public List<GenderVO> countGender();
	public List<AgeVO> countAge();
	public List<DurationVO> searchDuration(@Param("startDate") String startDate, @Param("endDate")String endDate);
	public List<SearchBoardVO> searchBoard(@Param("memberid") String memberid);
	public List<SearchReplyVO> searchReply(@Param("memberid") String memberid);
	public void passwordEdit(@Param("memberid")String memberid, @Param("memberpw")String memberpw);
}
