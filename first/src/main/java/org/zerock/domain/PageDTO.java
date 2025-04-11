package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int total; // 총 게시글 수
	private Criteria cri;
	
	private int realEnd; // 실제 마지막 페이지 번호
	private int startPage; // 보이는 첫번째 페이지번호
	private int endPage; // 보이는 마지막 페이지번호
	private boolean prev, next; // 다음페이지, 전페이지 버튼 유무 판별
	
	
	public PageDTO (Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		this.realEnd = (this.total-1)/10+1; // 실제 마지막 페이지 번호
		this.startPage = ((cri.getPageNum()-1)/10)*10 + 1; // 보이는 첫번째 페이지번호
		this.endPage = ((cri.getPageNum()-1)/10)*10 + 10; // 보이는 마지막 페이지번호
		if (this.realEnd < this.endPage) {
			this.endPage = this.realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < this.realEnd;
		
	}
}
