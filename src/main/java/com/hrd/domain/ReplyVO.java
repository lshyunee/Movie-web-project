package com.hrd.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno;
	private Long mno;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}