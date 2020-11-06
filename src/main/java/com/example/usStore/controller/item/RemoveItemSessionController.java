package com.example.usStore.controller.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;


/**
 * @author Juergen Hoeller
 * @since 30.11.2003
 * @modified-by Changsup Park
 */
@Controller
public class RemoveItemSessionController { 
   
   @RequestMapping("/shop/item/goToIndex.do") //go index(remove sessions)
   public String Index(SessionStatus sessionStatus, HttpServletRequest rq)
   {
      HttpSession session = rq.getSession(false);
         System.out.println("item 작성 세션 종료  index");
         session.removeAttribute("itemForm");   //itemForm session close
         session.removeAttribute("status");      //edit flag Session close
         session.removeAttribute("GroupBuying"); 
         session.removeAttribute("Auction"); 
         session.removeAttribute("handMadeForm"); 
         session.removeAttribute("secondHandForm");
         session.removeAttribute("sessionCart");
         
         return "redirect:/shop/index.do";
   }
   
   @RequestMapping("/shop/account/goToIndex.do") //go index(remove sessions)
   public String goIndex(SessionStatus sessionStatus, HttpServletRequest rq)
   {
      HttpSession session = rq.getSession(false);
         System.out.println("account 세션 종료  index");
         session.removeAttribute("accountForm");
         
         return "redirect:/shop/index.do";
   }
}