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
public class AuthVO implements Serializable {  // 🔥 직렬화 추가!
    private static final long serialVersionUID = 1L;
	public String memberid;
	public String auth;
}
