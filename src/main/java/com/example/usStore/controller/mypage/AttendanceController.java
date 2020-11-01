package com.example.usStore.controller.mypage;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AttendanceController {
	
	@RequestMapping(value="/shop/viewCalendar.do", method = RequestMethod.GET)      //item.jsp 이동
	   public String showCalendar() {
	    
		   return "account/Calendar";
	   }
	
	@RequestMapping(value="/shop/checkAttend.do", method = RequestMethod.POST, produces = "application/json")   
	@ResponseBody
	   public String checkAttend() {   
	     System.out.println("checkAttend.do");	     

	     return new SimpleDateFormat("yyyy-MM-dd").format(Timestamp.valueOf(LocalDate.now().atStartOfDay()));
	   }
	
	@RequestMapping(value = "/shop/checkAttend.do", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	  public String getCalendarList(HttpServletRequest request) {
		System.out.println("GET");
		
		return new SimpleDateFormat("yyyy-MM-dd").format(Timestamp.valueOf(LocalDate.now().atStartOfDay()));
		}
}
