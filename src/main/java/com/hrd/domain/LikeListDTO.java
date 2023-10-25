package com.hrd.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class LikeListDTO {
	private int likeCnt;
	private List<LikeListVO> list;
}
