package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	public Long bno;
	public String title;
	public String content;
	public String writer;
	public Date boardDate;
	public int hitCnt;
	public int boardLike;
	public int replyCnt;
	public List<BoardAttachVO> attachList;

}
