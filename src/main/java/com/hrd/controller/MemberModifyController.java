package com.hrd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hrd.domain.MemberVO;
import com.hrd.service.MemberService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/modifyM/")
@Log4j
public class MemberModifyController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping(value = "/{userid}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_ATOM_XML_VALUE })
	public ResponseEntity<MemberVO> get(@PathVariable("userid") String userid) {
		log.info("get-userid===========" + userid);
		return new ResponseEntity<>(service.get(userid), HttpStatus.OK);
	}
	
	@DeleteMapping(value="/{userid}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("userid") String userid){
		log.info("remove-userid===========" + userid);
		return service.removeMember(userid)==1?new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{userid}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody MemberVO vo, @PathVariable("userid") String userid){
		log.info("modify-userid============" + userid);
		log.info(vo);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpw(passwordEncoder.encode(vo.getUserpw()));
		vo.setUserid(userid);
		return service.modifyMember(vo)==1?new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
