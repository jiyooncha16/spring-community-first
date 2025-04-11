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
public class GenderVO {
	public int gender;
	public int count;
	public int ratio;
}
