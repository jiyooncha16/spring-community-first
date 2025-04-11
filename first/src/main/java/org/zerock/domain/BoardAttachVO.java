package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardAttachVO {
	public String uuid;
	public String uploadPath; // 업로드경로
	public String fileName; // 본 이름
	public boolean fileType; // 이미지 T, 파일 F
	
	private Long bno;
}
