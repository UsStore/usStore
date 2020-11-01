package com.example.usStore.controller.item;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.GroupBuying;
import com.example.usStore.domain.HandMade;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.Tag;
import com.example.usStore.service.HandMadeFormValidator;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.MyPageFacade;

import java.io.File;
import java.net.URL;

@Controller
@SessionAttributes({"handMadeForm", "handMadeList"})
public class HandMadeFormController {

   private static final String ADD_HANDMADE_FORM = "product/addHandMade";
   private static final String CHECK_FORM3 = "product/checkHandMade";
   private static final String HANDMADE_LIST = "product/handMade";
   private static final String DETAIL = "product/viewHandMade";
   
   @Autowired
   private ItemFacade itemFacade;

   @Autowired
   private MyPageFacade myPageFacade;
   
   @Autowired
   public void setitemFacade(ItemFacade itemFacade) {
      this.itemFacade = itemFacade;
   }
   
   @ModelAttribute("handMadeForm")
   public HandMadeForm createHandMadeForm() {
      return new HandMadeForm();
   }
   
   ////////////////////////////////////////////////
   // HandMade List Controller
   ////////////////////////////////////////////////

   // HandMade 리스트 초기 화면 출력시 실행되는 Controller
   @RequestMapping("/shop/handMade/listItem.do")
   public String listHandMade (
         @RequestParam("productId") int productId, ModelMap model, HttpServletRequest rq) throws Exception {
	   
		HttpSession session = rq.getSession(false);
		Account account = null;
		if (session.getAttribute("userSession") != null) {
			UserSession userSession = (UserSession) session.getAttribute("userSession");
			if (userSession != null) { // 로그인상태이면 대학정보 가져온다
				account = userSession.getAccount();
			}
		}

		PagedListHolder<HandMade> handMadeList = new PagedListHolder<HandMade>(
				this.itemFacade.getHandMadeList(account));
		handMadeList.setPageSize(4);

		model.put("handMadeList", handMadeList);
		model.put("productId", productId);
		return HANDMADE_LIST;
   }
   
   // 아이템 4개마다 페이지 구분, 다음 페이지나 이전 페이지로 전환하도록 해주는 Controller
   @RequestMapping("shop/handMade/listItem2.do")
   public String listHandMade2 (
		 @RequestParam("productId") int productId, 
         @ModelAttribute("handMadeList") PagedListHolder<HandMade> handMadeList,
         @RequestParam("pageName") String page,
         ModelMap model) throws Exception {
      if ("next".equals(page)) {
         handMadeList.nextPage();
      }
      else if ("previous".equals(page)) {
         handMadeList.previousPage();
      }
      model.put("handMadeList", handMadeList);
      model.put("productId", productId);
      return HANDMADE_LIST;
   }
   
   @RequestMapping("/shop/handMade/index.do") // go index(remove sessions)
   public String goIndex(SessionStatus sessionStatus, HttpServletRequest rq) {
      System.out.println("go back index.do From [add / edit product]");
      HttpSession session = rq.getSession(false);

      sessionStatus.setComplete();// groupBuying session close
      session.removeAttribute("itemForm"); // itemForm session close
      session.removeAttribute("status"); // edit flag Session close

      return "redirect:/shop/index.do";
   }
   
   ////////////////////////////////////////////////
   // HandMade Add Controller
   ////////////////////////////////////////////////
   
   @RequestMapping("/shop/handMade/gobackItem.do")      // item.jsp
   public String step1(@ModelAttribute("handMadeForm") HandMadeForm handMadeForm, 
         @RequestParam("productId") int productId) {
      System.out.println("go back to item.jsp");
      return "redirect:/shop/item/addItem.do?productId=" + productId;   // step1 form view(item.jsp)
   }
   
   @RequestMapping(value="/shop/handMade/addItem2.do", method = RequestMethod.GET)
   public String step2(@ModelAttribute("handMadeForm") HandMadeForm handMadeForm, 
         @RequestParam("productId") int productId, Model model, HttpServletRequest rq) {

      HttpSession session = rq.getSession(false);
      if(session.getAttribute("status") != null) {
         int status = (int) session.getAttribute("status");
         int itemId = status;
         
         System.out.println("from edit - addItem2.do");
         HandMade handMade = itemFacade.getHandMadeById(itemId);
         System.out.println("itemFacade : " + itemFacade.getHandMadeById(itemId));
         handMadeForm.setItemId(itemId);
         handMadeForm.setListPrice(handMade.getListPrice());
         System.out.println(handMadeForm);
      }
      model.addAttribute("productId", productId);
      return ADD_HANDMADE_FORM; // addHandMade.jsp
   }
   
   @GetMapping("handMade/step2")      // step3 -> step2
   public String step2FromStep3() {
      return ADD_HANDMADE_FORM;   // step2 form view
   }

   @PostMapping("/shop/handMade/step3.do")      // step2 -> step3 占쎌뵠占쎈짗
   public String step3(
         @ModelAttribute("handMadeForm") HandMadeForm handMadeForm, BindingResult bindingResult, 
         HttpServletRequest rq, ItemForm itemForm, Model model, ModelMap modelMap, MultipartHttpServletRequest multi) {
      
      System.out.println("step3.do(before check form)");
      HttpSession session = rq.getSession(false);
      new HandMadeFormValidator().validate(handMadeForm, bindingResult);

      System.out.println("step3.do : " + handMadeForm);
      
      if(session.getAttribute("itemForm") != null) {
         itemForm = (ItemForm) session.getAttribute("itemForm");
         System.out.println("itemformSession: " + itemForm);   //print itemformSession toString
      }
      if(handMadeForm.getListPrice() >= itemForm.getUnitCost()) {
         bindingResult.rejectValue("listPrice", "isSmall");
      }
      
      if (bindingResult.hasErrors()) {   //유효성 검증 에러 발생시
         model.addAttribute("productId", itemForm.getProductId());
         return ADD_HANDMADE_FORM;
      }
      
      //업로드 파일이 저장될 경로
      String root_path = rq.getSession().getServletContext().getRealPath("/");  
      
      //파일경로
      String attach_path = "images" + File.separator + "uploadImg" + File.separator;
      
      File Folder = new File(root_path + attach_path);
      
      // 해당 디렉토리가 없을경우 디렉토리를 생성
        if (!Folder.exists()) {
           try{
               Folder.mkdir(); //폴더 생성
               System.out.println("폴더가 생성되었습니다.");
                } 
                catch(Exception e){
               e.getStackTrace();
           }        
              }else {
           System.out.println("이미 폴더가 생성되어 있습니다.");
        }
      
      //파일 이름
      MultipartFile file = multi.getFile("file");
      
      UUID uuid = UUID.randomUUID();   //파일명 중복 방지
      String imgName = file.getOriginalFilename();
      String fileName = uuid.toString() + "_" + imgName;
      String imgPath = root_path + attach_path + fileName;
      
      //파일 업로드
      try {
         file.transferTo(new File(imgPath));   //업로드 한 파일 데이터를 지정한 경로(파일)에 저장                  
         itemForm.setImgUrl(imgPath);
      } catch(Exception e) {
         System.out.println("이미지 업로드 오류");
      }
      
      System.out.println("handMadeForm step3.do : " + handMadeForm);
      
      model.addAttribute(itemForm);
      model.addAttribute("imgName", imgName);
      modelMap.addAttribute("tags", itemForm.getTags());
      return CHECK_FORM3;   // step3(CHECK_FORM3)
   }
   
   @PostMapping("/shop/handMade/detailItem.do")      // step3 -> done
   public String finalAddHandMade(@ModelAttribute("handMadeForm") HandMadeForm handMadeForm, 
         ItemForm itemFormSession, BindingResult result, Model model, HttpServletRequest rq, 
         SessionStatus sessionStatus, ModelMap modelMap) {
      int status = 0;
      System.out.println("detailItem.do");
      
      HttpSession session = rq.getSession(false);
      itemFormSession = (ItemForm) session.getAttribute("itemForm");   
      if(session.getAttribute("status") != null) {
         status = (int) session.getAttribute("status");
      }
      
      UserSession userSession = (UserSession) session.getAttribute("userSession");
      String suppId = userSession.getAccount().getUserId();
      System.out.println("suppId: " + suppId);
      
      if(session.getAttribute("itemForm") != null) {
         System.out.println("itemformSession: " + itemFormSession);   //print itemformSession toString
      }
      
      System.out.println("detail.do : " + handMadeForm);
   
      //put itemformSession to item
      Item item = new Item(itemFormSession.getUnitCost(), itemFormSession.getTitle(), 
            itemFormSession.getDescription(), itemFormSession.getQty(), suppId,    // must change userId -> loginCommand.getUserId()
            itemFormSession.getProductId(), itemFormSession.getImgUrl());
      
      if(status != 0) {
         //수정 필요
         item.setItemId(status);
         item.setViewCount(itemFormSession.getViewCount());
         itemFacade.updateItem(item);
         System.out.println("itemUpdated" + item);
         
         List<Tag> tags = itemFacade.getTagByItemId(status);
         System.out.println("tag size : " + tags.size());   //0
         
         // 기존 태그 전부 삭제
         if(tags.size() > 0) {
            itemFacade.deleteTag(status);
            tags.removeAll(tags);
         }
      }

      System.out.println("itemId: " + item.getItemId());   //print itemformSession toString
   
      // generate tags(only have tagName)
      for (int i = 0; i < itemFormSession.getTags().size(); i++) {
         item.makeTags(itemFormSession.getTags().get(i)); // if(tag != null && "") then addTags
      }
      System.out.println("최종 태그:" + item.getTags());

      HandMade handMade = new HandMade(item, handMadeForm.getItemId(), handMadeForm.getListPrice());
      System.out.println("detail = " + handMade);
      //transaction
      if(status != 0) {
         itemFacade.updateHandMade(handMade); // update DB
         System.out.println("update = " + handMade);
      }
      else {
         itemFacade.insertHandMade(handMade);   // insert DB
         System.out.println("update = " + handMade);
      }
      System.out.println("finally = " + handMade);
      sessionStatus.setComplete();   // groupBuying, editStatus session close
      session.removeAttribute("itemForm");   //itemForm session close
      session.removeAttribute("status");
      System.out.println("detail ItemId = " + handMade.getItemId());
      return "redirect:/shop/handMade/viewItem.do?itemId=" + handMade.getItemId() + "&productId=" + item.getProductId();
   }
   
   ////////////////////////////////////////////////
   // HandMade View Controller
   ////////////////////////////////////////////////
   
   @RequestMapping("/shop/handMade/viewItem.do")
   public String handMadeView(@RequestParam("itemId") int itemId,   
         @RequestParam("productId") int productId, 
         HttpServletRequest rq, Model model, ModelMap modelMap) {
      
      System.out.println("viewItem.do");
      System.out.println("itemId:" + itemId);   
      //이미지 위한 경로 확인
      System.out.println("경로: " + rq.getSession().getServletContext().getRealPath("/")); 
      System.out.println(File.separator + "& " + "/");
      
      String victim = null;
      String isAccuse = "false";
      HttpSession session = rq.getSession(false);
      
      if(session.getAttribute("userSession") != null) {
         UserSession userSession = (UserSession) session.getAttribute("userSession");
      
         if (userSession != null) {// attacker = 판매자 아이디, victim = 세션 유저 아이디
            victim = userSession.getAccount().getUserId();
            String attacker = this.itemFacade.getUserIdByItemId(itemId);
            isAccuse = this.myPageFacade.isAccuseAlready(attacker, victim);
         }
      }
      
      System.out.println("View HandMade Controller !!");
      
      HandMade handMade = this.itemFacade.getHandMadeById(itemId);
      handMade.setItemId(itemId);
      System.out.println(handMade);
      
      System.out.println("viewCount : " + handMade.getViewCount());
      this.itemFacade.updateViewCount(handMade.getViewCount() + 1, itemId);
      System.out.println("object's viewcount ++ ? : " + handMade);

      List<Tag> tags = new ArrayList<Tag>();
      tags = itemFacade.getTagByItemId(handMade.getItemId());
      
      model.addAttribute("isAccuse", isAccuse);
      model.addAttribute("productId", productId);
      model.addAttribute("handMade", handMade);
      
      modelMap.addAttribute("tags", tags);
      
      return DETAIL;
   }
   
   @RequestMapping(value="/shop/handMade/getImage.do")
   public void getImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
      int itemId = Integer.parseInt(request.getParameter("itemId"));
      
      HandMade handMade = itemFacade.getHandMadeById(itemId);
      
      String url = handMade.getImgUrl();
      System.out.println("url: " + url);

      URL fileUrl = new URL("file:///" + url);
      IOUtils.copy(fileUrl.openStream(), response.getOutputStream());   // IOUtils.copy는 input에서 output으로 encoding 맞춰서 복사하는 메소드
   }
   
   ////////////////////////////////////////////////
   // HandMade Edit Controller
   ////////////////////////////////////////////////
   
   @RequestMapping("/shop/handMade/edit.do") //edit Item
   public String editItem(ItemForm itemForm, 
               Item item,   @RequestParam("itemId") int itemId, HttpServletRequest rq)
   {
      HttpSession session = rq.getSession(true);
      
      HandMade handMade = itemFacade.getHandMadeById(itemId);
      List<Tag> tags = new ArrayList<Tag>();
      tags = itemFacade.getTagByItemId(itemId);
      
      System.out.println("edit.do");
      if(session.getAttribute("status") != null) {
         int status = (int) session.getAttribute("status");
         System.out.println("itemId(status) : " + status);
      }
      
      if(session.getAttribute("itemForm") != null) {
         itemForm = (ItemForm) session.getAttribute("itemForm");
      } else {
         itemForm = new ItemForm();
      }
      itemForm.setItemId(itemId);
      itemForm.setUnitCost(handMade.getUnitCost());
      itemForm.setTitle(handMade.getTitle());
      itemForm.setDescription(handMade.getDescription());
      itemForm.setQty(handMade.getQty());
      itemForm.setViewCount(handMade.getViewCount());
      itemForm.setTags(handMade.getTags());

      session.setAttribute("itemForm", itemForm);
      session.setAttribute("status", itemId);
      System.out.println(itemForm);
      
      return "redirect:/shop/item/addItem.do?productId=" + handMade.getProductId();
   }
   
   
   ////////////////////////////////////////////////
   // HandMade Delete Controller
   ////////////////////////////////////////////////
   
   @RequestMapping("/shop/handMade/deleteItem.do")
   public String delete(@RequestParam("productId") int productId, @RequestParam("itemId") int itemId, ModelMap model) {
      this.itemFacade.deleteItem(itemId);
      return "redirect:/shop/handMade/listItem.do?productId=" + productId;
   }
}