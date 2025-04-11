package org.zerock.domain;

import java.util.Date;

public class ReplyVO {
	public Long rno;
	public String reply;
	public String replyer; //50바이트 이하
	public Date replyDate;
	public int replyLike;
	public Long bno;
	
	//public int replyCnt;

    public Long getBno() {
        return bno;
    }

    public void setBno(Long bno) {
        this.bno = bno;
    }
    public Long getRno() {
        return rno;
    }
    
    public void setRno(Long rno) {
        this.rno = rno;
    }
    

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getReplyer() {
        return replyer;
    }

    public void setReplyer(String replyer) {
        this.replyer = replyer;
    }


}
