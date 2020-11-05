package com.example.usStore.controller.item;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.SecondHand;
import com.example.usStore.domain.Tag;
import com.example.usStore.domain.University;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.MyPageFacade;
import com.example.usStore.service.facade.UsStoreFacade;

@Controller
@SessionAttributes("secondHandList")
public class SecondHandController {

   private ItemFacade itemFacade;
   private MyPageFacade myPageFacade;
   private UsStoreFacade usStoreFacade;
   
   @Autowired
   public void setItemFacade(ItemFacade itemFacade) {
      this.itemFacade = itemFacade;
   }

   @Autowired
   public void setMyPageFacade(MyPageFacade myPageFacade) {
      this.myPageFacade = myPageFacade;
   }
   
   @Autowired
   public void setUsStoreFacade(UsStoreFacade usStoreFacade) {
      this.usStoreFacade = usStoreFacade;
   }
   
   @RequestMapping("/shop/secondHand/listItem.do")
   public String secondHandList(@RequestParam("productId") int productId, 
		   @RequestParam(value="region", required=false) String region,
		   @RequestParam(value="filterUniv", required=false) String filterUniv,
		   Model model, HttpServletRequest rq) throws Exception {
      /*현재 로그인한 유저가 있다면 그 유저의 대학 필드를 우선적으로 보여주고 
         만약 로그인이 안된 상태에서는 대학 필터링 없이 보여준다.*/
     HttpSession session = rq.getSession(false);
   
     String univName = null; //Account에 속한 필드 의미 
     String univAddr = null;
     if (session.getAttribute("userSession") != null) { // 로그인 했을 때  
            UserSession userSession = (UserSession)session.getAttribute("userSession") ;
            if (userSession != null) {  //로그인상태이면 대학정보 가져온다 
            	Account account = userSession.getAccount();
            	univName = account.getUniversity();
            	univAddr = this.myPageFacade.getUnivAddrByName(univName);
            }
     } 
     
     // 전체 리스트 보여줌 - 디폴트 
     PagedListHolder<SecondHand> secondHandList = new PagedListHolder<SecondHand>(this.itemFacade.getSecondHandList(univName));
     
     if(region != null && filterUniv == null) {  // 지역별 게시물 필터링 적용했을 때 
    	 System.out.println("지역별 필터링 적용했을 때 선택한 지역 :  " + region);
    	 HashMap<String, String> param = new HashMap<String, String>();
    	 param.put("region", region); 
    	 param.put("univName", univName); 
    	 secondHandList = new PagedListHolder<SecondHand>(this.itemFacade.getSHListByRegion(param));
     } 
     if(region == null && filterUniv != null) { // 지도에서 대학교 별로 게시물 필터링 했을 때 
    	 System.out.println("지도에 대학교 별로 게시물 필터링 선택한 대학교이름 :  " + filterUniv);
    	 secondHandList = new PagedListHolder<SecondHand>(this.itemFacade.getSHListByUniv(filterUniv));
     }
    

     secondHandList.setPageSize(4);
     
     model.addAttribute("secondHandList", secondHandList);
     model.addAttribute("productId", productId);
     model.addAttribute("university", univAddr); //로그인 사용자의 대학교 도로명 주소 -> 널값이면 jsp 에서 안보여줌 
     model.addAttribute("filterUniv", filterUniv);
     return "product/secondHand";
   }
   
	@RequestMapping(value = "/api/secondHand/map.do", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody         
	public List<University> getSHMapInfo(HttpServletResponse response) throws IOException {
		List<University> univMapList = this.itemFacade.getSHMapInfo();
		if (univMapList == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		return univMapList; 
	}
   
   @RequestMapping("/shop/secondHand/listItem2.do")
   public String secondHandList2(@ModelAttribute("secondHandList") PagedListHolder<Item> secondHandList,
         @RequestParam("pageName") String page, @RequestParam("productId") int productId, Model model)
         throws Exception {
      if ("next".equals(page)) {
         secondHandList.nextPage();
      } else if ("previous".equals(page)) {
         secondHandList.previousPage();
      }
      model.addAttribute("secondHandList", secondHandList);
      model.addAttribute("productId", productId);
      return "product/secondHand";
   }

   @RequestMapping("/shop/secondHand/viewItem.do")
   public String viewSecondHand(@RequestParam("itemId") int itemId, @RequestParam("productId") int productId,
         Model model, HttpServletRequest request) {
      String victim = null;
      String isAccuse = "false";
      String attacker = this.itemFacade.getUserIdByItemId(itemId);
      HttpSession session = request.getSession(false);
      if (session.getAttribute("userSession") != null) {
         UserSession userSession = (UserSession)session.getAttribute("userSession") ;
         if (userSession != null) {// attacker = 판매자 아이디, victim = 세션 유저 아이디
            victim = userSession.getAccount().getUserId();
            isAccuse = this.myPageFacade.isAccuseAlready(attacker, victim);
         }
      }
      
      //판매자 대학교 이름
      String univName = this.usStoreFacade.getAccountByUserId(attacker).getUniversity(); 
      
      List<Tag> tags = itemFacade.getTagByItemId(itemId);
      SecondHand sh = this.itemFacade.getSecondHandItem(itemId);
      this.itemFacade.updateViewCount(sh.getViewCount() + 1, itemId); //조회수 1증가
      
      model.addAttribute("sh", sh);
      model.addAttribute("isAccuse", isAccuse);
      model.addAttribute("tags", tags);
      model.addAttribute("university", univName); // 판매자의 대학교 이름으로 전달 
      return "product/viewSecondHand";
   }
   
     @RequestMapping("/shop/secondHand/delete.do") 
     public String delete(@RequestParam("productId") int productId,
     @RequestParam("itemId") int itemId, ModelMap model) {
     
        this.itemFacade.deleteItem(itemId); 
        return "redirect:/shop/secondHand/listItem.do?productId=" + productId;
     }

     @RequestMapping(value = "/rest/user/{userId}", method = RequestMethod.GET, produces="application/json")
     @ResponseBody
     public Account getSellerInfo(@PathVariable("userId") String userId, 
         HttpServletResponse response) throws IOException {
      
         Account result = this.usStoreFacade.getAccountByUserId(userId);
         if (result == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
         }          
         return result;
      }
}