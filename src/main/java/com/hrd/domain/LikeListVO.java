package com.hrd.domain;

import java.util.Date;

import lombok.Data;

@Data
public class LikeListVO {
	private String userid;
	private Long mno;
	private Long lno;
	private int like_qty;
	private int find_like;
	private Date regDate;
	private String title;
	private Long rating;
}
