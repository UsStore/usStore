package com.example.usStore.controller.mypage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.usStore.domain.Events;
import com.example.usStore.service.facade.UsStoreFacade;

@Controller
public class AttendanceController {

   @Autowired
   private UsStoreFacade usStore;

   @RequestMapping(value = "/shop/viewCalendar.do", method = RequestMethod.GET)
   public String showCalendar() {
	   System.out.println("calendar");

      return "account/Calendar";
   }
   
   //달력 보일 경우
   @RequestMapping(value = "/shop/checkAttend.do", method = RequestMethod.GET, produces = "application/json")
   @ResponseBody
   public List<Events> getCalendarList(HttpServletRequest rq) {
      System.out.println("GET");

      String userId = "";

      HttpSession session = rq.getSession(false);

      if (session.getAttribute("userSession") != null) {
         UserSession userSession = (UserSession) session.getAttribute("userSession");
         userId = userSession.getAccount().getUserId();
      }
      
      List<String> calList = usStore.getCalendarByDate(userId);
      List<Events> events = new ArrayList<>();
      
      for(int i  = 0; i < calList.size(); i ++) {
    	  Events event = new Events("출석", calList.get(i));
    	  events.add(event);
      }
      System.out.println("사용자 출석 날짜 정보: " + events);

      return events;    
   }
   
   //출석체크하기 클릭한 경우
   @RequestMapping(value = "/shop/checkAttend.do", method = RequestMethod.POST)
   @ResponseBody
   public String checkAttend(HttpServletRequest rq) {
      System.out.println("post");
      String userId = "";

      SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd");
      Date day = new Date();
      String today = format.format(day);
      System.out.println("오늘: " + today);
      
      HttpSession session = rq.getSession(false);

      if (session.getAttribute("userSession") != null) {
         UserSession userSession = (UserSession) session.getAttribute("userSession");
         userId = userSession.getAccount().getUserId();
      }
      
      List<String> dateList = usStore.getCalendarByDate(userId);
      System.out.println("getCalendarByDate: " + dateList);
      
      for(String date : dateList) {	//출첵 기록 중, 오늘의 기록이 이미 있을 경우 = (이미 출첵한 경우)
    	  if(date.equals(today)) {
    		  return "y";
    	  }
      }
      
      usStore.updatePoint(userId, 1);    //출첵을 아직 안 한 경우, (출첵 처리 + 사용자에게 1포인트 지급)
      return "n";
   }

}