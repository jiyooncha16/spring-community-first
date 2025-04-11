package org.zerock.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode 포함
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 포함한 생성자
public class MemberVO implements Serializable {  // 🔥 직렬화 추가!
    private static final long serialVersionUID = 1L;  // 🚀 버전 관리용 ID 추가
	public String memberid;
	public String memberpw;
	public String name; // 이름
	public String gender;
	public int age;
	public Date registerDate;
	public boolean enabled; // 계정 활성화
	public List<AuthVO> authList; // 여러 개 권한 가능

	//public String auth; member, admin
}
