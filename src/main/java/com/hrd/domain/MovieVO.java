package com.hrd.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MovieVO {
	private Long mno;
	private String title;
	private String genre;
	private String director;
	private String content;
	private String regdate;
	private MovieAttachVO attach;
	private Long rating;
	private String writer;
	private Date uploaddate;
}
