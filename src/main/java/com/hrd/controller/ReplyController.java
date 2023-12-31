package com.hrd.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hrd.domain.Criteria;
import com.hrd.domain.ReplyDTO;
import com.hrd.domain.ReplyVO;
import com.hrd.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;

	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("ReplyVO:" + vo);
		int insertCount = service.register(vo);
		log.info("insertCount: " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	} // insert

	@GetMapping(value = "/pages/{mno}/{page}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyDTO> getList(@PathVariable("page") int page, @PathVariable("mno") Long mno) {
		log.info("getList-----");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getListPage(cri, mno), HttpStatus.OK);
	}// getList

	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("get-rno:" + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("( principal.username == #vo.replyer ) or hasRole('ROLE_ADMIN')")
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		log.info("remove-rno:" + rno);
		log.info("replyer: " + vo.getReplyer());
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}// delete
	
	@PreAuthorize("( principal.username == #vo.replyer ) or hasRole('ROLE_ADMIN')")
	@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH},
			value="/{rno}", 
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo, 
			@PathVariable("rno")Long rno){
		log.info("modify-rno:"+rno);
		log.info("ReplyVO:" + vo);
		vo.setRno(rno);
		return service.modify(vo)==1?new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	} // modify
}