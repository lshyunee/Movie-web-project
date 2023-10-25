package com.hrd.controller;

import java.security.Principal;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hrd.domain.AuthVO;
import com.hrd.domain.Criteria;
import com.hrd.domain.MemberVO;
import com.hrd.domain.PageDTO;
import com.hrd.mapper.MemberMapper;
import com.hrd.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private MemberService service;
	

	@GetMapping("/join")
	public void create() {

	}

	@PostMapping("/join")
	public String create(MemberVO member) {
		AuthVO role = new AuthVO();
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		member.setUserpw(passwordEncoder.encode(member.getUserpw()));
		role.setAuth("ROLE_ADMIN");
		member.setAuthList(Arrays.asList(role));
		mapper.joinMember(member);
		log.info("=============");

		return "redirect:/customLogin";
	}

	@PostMapping("/authCheck")
	public String createAuth(AuthVO auth) {
		mapper.checkAuthority(auth);
		log.info("createAuth()");

		return "redirect:/customLogin";
	}
	
	@PostAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/memberManage")
	public void getList(Criteria cri, Model model) {
		log.info("=========list");
		log.info("cri");
		int total = service.getTotal(cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/mypage")
    public void mypage(Principal principal, Model model) {
        
        log.info("마이페이지 창으로 이동");
        log.info("유저아이디: " + principal.getName());
        String userid = principal.getName();
        MemberVO vo = service.get(userid);
        model.addAttribute("member", vo);
    }
	
	@GetMapping("/withdrawal")
    public void withdrawal(Principal principal, Model model) {
        log.info("유저아이디: " + principal.getName());
        String userid = principal.getName();
        MemberVO vo = service.get(userid);
        model.addAttribute("member", vo);
    }
	
	//회원탈퇴
	@PostMapping("/withdrawalCP")
	public String remove(@RequestParam("userid") String userid, RedirectAttributes rttr){
		log.info("remove-userid===========" + userid);
		if(service.removeMember(userid) == 1) {
			rttr.addFlashAttribute("result", "success");
			//회원 탈퇴시 강제 로그아웃
			SecurityContextHolder.clearContext();
		}
		return "redirect:/customLogin";
	}
	
	@GetMapping("/modifyMyInfo")
    public void modifyMyInfo(Principal principal, Model model) {
        log.info("유저아이디: " + principal.getName());
        String userid = principal.getName();
        MemberVO vo = service.get(userid);
        model.addAttribute("member", vo);
    }
	
	@PostMapping("/modifyMyInfo")
	public String modifyMyInfo(MemberVO vo, RedirectAttributes rttr) {
		log.info("modify-userid============" );
		log.info("MemberVO" + vo);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpw(passwordEncoder.encode(vo.getUserpw()));
		if(service.modifyMember(vo)==1) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/member/mypage";
	}

	/*
	@GetMapping("/pwCheck")
	public void loginInput(String error, String logout,  Model model) {
		SecurityContextHolder.clearContext();
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	*/
	
	

	/*
	@PostMapping("/pwCheck")
    public String pwCheck(@RequestParam("inputText") String inputText, RedirectAttributes rttr) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        log.info("pwCheck()");
        int result = service.pwCheck(inputText);
        
        
        if(encoder.matches(inputText, userpw)) {
            log.info("pw 재확인 완료..");
            return "redirect:/member/mypage";
        }
        else {
            rttr.addFlashAttribute("msg", "비밀번호를 다시 확인해 주세요.");
            return "redirect:/member/mypage";
        }
    }
    */
	
	// 아이디 중복 검사
	@PostMapping("/idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("userid") String userid) {
		log.info("idCheck()");
		int result = service.idCheck(userid);
		log.info("결과값 = " + result);
		if (result != 0) {
			return "fail"; // 중복 아이디가 존재
		} else {
			return "success"; // 중복 아이디 x
		}
	} // idCheck() 종료
	
}
