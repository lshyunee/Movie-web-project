package com.hrd.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hrd.domain.Criteria;
import com.hrd.domain.LikeListVO;
import com.hrd.domain.MemberVO;
import com.hrd.domain.MovieAttachVO;
import com.hrd.domain.MovieVO;
import com.hrd.domain.PageDTO;
import com.hrd.service.LikeListService;
import com.hrd.service.MovieService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie/*")
public class MovieController {
	@Autowired
	private MovieService service;

	@Autowired
	private LikeListService likeservice;

	@GetMapping("/list")
	public void getList(Criteria cri, Model model) {
		log.info("=========");
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/list2")
	public void getList2(Criteria cri, Model model) {
		log.info("=========");
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(MovieVO movie, RedirectAttributes rttr) {
		log.info("register: " + movie);
		if (movie.getAttach() != null) {
			log.info(movie.getAttach());
		}
		service.register(movie);
		rttr.addFlashAttribute("result", movie.getMno());

		return "redirect:/movie/list";
	}

	@GetMapping("/getAttach")
	@ResponseBody // 화면 이동 안 하고 결과값 데이터 전달
	public ResponseEntity<MovieAttachVO> getAttach(Long mno) {
		log.info("getAttach:" + mno);
		return new ResponseEntity<>(service.getAttach(mno), HttpStatus.OK);
	}

	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String getRegister() {

		return "/movie/register";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({ "/info", "/modify" })
	public void info(@RequestParam("mno") Long mno, @ModelAttribute("cri") Criteria cri, Principal principal, Model model) throws Exception{
		log.info("=========");
		model.addAttribute("info", service.info(mno));
		
		LikeListVO likeListVO = new LikeListVO();
		likeListVO.setMno(mno);
		String userid = principal.getName();
		likeListVO.setUserid(userid);
		
		int heart = likeservice.findLike(likeListVO);
		System.out.println(heart);
		
		model.addAttribute("heart", heart);
	}
	
	@GetMapping({ "/infoAnony"})
	public void infoAnony(@RequestParam("mno") Long mno, @ModelAttribute("cri") Criteria cri, Principal principal, Model model) throws Exception{
		log.info("=========");
		model.addAttribute("infoA", service.info(mno));
	}

	@PreAuthorize("( principal.username == #movie.writer ) or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(MovieVO movie, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify" + movie);
		if (service.modify(movie) == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/movie/list" + cri.getListLink();
	}

	private void deleteFiles(MovieAttachVO attach) { // attach목록을 매개변수로 갖는 (첨부파일 목록을 반복문을 이용해서 전체 삭제)
		if (attach == null) {
			return;
		}
		log.info("delete attach files..............");
		log.info(attach); // attach한개한개의 정보를 변수로 접근
		try {
			// path클래스의 get매소드로 Path객체 만들어서 path가 존재하면 삭제하겠다
			Path file = Paths
					.get("C:\\movie\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
			Files.deleteIfExists(file);
		} catch (IOException e) {
			log.error("delete file error" + e.getMessage());
		}
	}

	@PreAuthorize("( principal.username == #writer ) or hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(@RequestParam("mno") Long mno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			String writer) {
		log.info("remove:" + mno);
		MovieAttachVO attach = service.getAttach(mno);
		if (service.remove(mno) == 1) {
			deleteFiles(attach);
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/movie/list" + cri.getListLink();
	}

	@GetMapping("/likeList")
	public void likeList(@RequestParam("userid") String userid, Model model) {
		log.info("list");
		model.addAttribute("list", likeservice.getLikeList(userid));
	}
	
	@ResponseBody
    @RequestMapping(value = "/heart", method = RequestMethod.POST, produces = "application/json")
    public int heart(@RequestParam("userid") String userid, @RequestParam("mno") Long mno) throws Exception {

        LikeListVO likeList = new LikeListVO();

        likeList.setMno(mno);
        likeList.setUserid(userid);
        

		int heart = likeservice.findLike(likeList);
        
        System.out.println(heart);

        if(heart >= 1) {
            likeservice.removeLike(mno, userid);
            heart=0;
        } else {
            likeservice.addLike(mno, userid);
            heart=1;
        }

        return heart;

    }
	

	@PostMapping("/likeListRemove")
	public String likeList(@RequestParam("mno") Long mno, Principal principal, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr)throws Exception {
		
		String userid = principal.getName();
		if (likeservice.removeLike(mno, userid) == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		log.info("remove:" + mno + userid);

		return "redirect:/movie/likeList?userid=" + userid + cri.getListLink();
	}
	
}