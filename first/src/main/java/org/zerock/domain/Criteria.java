package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int amount; // 한 페이지 당 게시물 수
	private int pageNum; // 현재페이지
	private String keyword;
	
	public Criteria() { // 주소에 파라미터 입력 안 하고 그냥 /board/list 했을 경우
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getAmount() { 
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) { 
        this.keyword = keyword;
    }
    
    

}
 