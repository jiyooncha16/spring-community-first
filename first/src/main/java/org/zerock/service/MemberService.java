package org.zerock.service;

import java.util.Date;
import java.util.List;

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

public interface MemberService {
	
	public void join(MemberVO vo);
	public int checkid(String memberid);
	public String searchid(String name);
	public MemberVO read(String memberid);
	public void profileEdit(MemberVO member);
	public List<AdminVO> allMember();
	public int countMember();
	public int countBoard();
	public int countReply();
	public List<GenderVO> countGender();
	public List<AgeVO> countAge();
	public List<DurationVO> searchDuration(String startDate, String endDate);
	public List<SearchBoardVO> searchBoard(String memberid);
	public List<SearchReplyVO> searchReply(String memberid);
	public void passwordEdit(String memberid, String memberpw);
}
