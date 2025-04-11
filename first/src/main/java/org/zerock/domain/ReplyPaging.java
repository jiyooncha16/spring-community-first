package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyPaging {
	private int page; // 표기할 마지막 페이지
	private Long bno; // 게시글 번호
	
	public ReplyPaging() { //기본값
		this(1);
	}
	
	public ReplyPaging(int page) {
		this.page = page;
	}

    public int getPage() { // 추가
        return page;
    }

    public void setPage(int page) { // 추가
        this.page = page;
    }
    
    public Long getBno() { // 추가
        return bno;
    }

    public void setBno(Long bno) { // 추가
        this.bno = bno;
    }
}