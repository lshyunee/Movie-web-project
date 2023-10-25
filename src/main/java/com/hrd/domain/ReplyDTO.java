package com.hrd.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyDTO {
	private int replyCnt;
	private List<ReplyVO> list;
}