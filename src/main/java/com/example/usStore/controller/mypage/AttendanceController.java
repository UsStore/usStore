package com.example.usStore.controller.mypage;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AttendanceController {
	
	@RequestMapping(value="/shop/viewCalendar.do", method = RequestMethod.GET)      //item.jsp 이동
	   public String showCalendar() {
	    
		   return "account/Calendar";
	   }
	
	@RequestMapping(value="/shop/checkAttend.do", method = RequestMethod.POST)   
	@ResponseBody
	   public String checkAttend(HttpServletRequest rq) {   
	     System.out.println("post");	     
	     String userId = "";
	     
	     HttpSession session = rq.getSession(false);
	      
	      if(session.getAttribute("userSession") != null) {         
	         UserSession userSession = (UserSession) session.getAttribute("userSession");
	         userId = userSession.getAccount().getUserId();
	      }
	      System.out.println("userId : " + userId);

	     return new SimpleDateFormat("yyyy-MM-dd").format(Timestamp.valueOf(LocalDate.now().atStartOfDay()));
	   }
	
	@RequestMapping(value = "/shop/checkAttend.do", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	  public String getCalendarList(HttpServletRequest request) {
		System.out.println("GET");
		
		return new SimpleDateFormat("yyyy-MM-dd").format(Timestamp.valueOf(LocalDate.now().atStartOfDay()));
		}
}
