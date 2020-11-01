package com.example.usStore.controller.order;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.example.usStore.domain.KakaoPayApproval;
import com.example.usStore.domain.KakaoPayReady;

import lombok.extern.java.Log;
 
@Service
@Log
@SessionAttributes({"sessionCart", "orderForm"})
public class Kakaopay {
 
    private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReady kakaoPayReady;
    private KakaoPayApproval kakaoPayApproval;
    private OrderForm orderForm;
    
    public String kakaoPayReady(HttpSession session, OrderForm orderForm) {
 
        RestTemplate restTemplate = new RestTemplate();
 
        System.out.println("kakaopayReady");
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "2d2343b15ecc5bce081443419956cef3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        
//        OrderForm orderForm = (OrderForm) request.getAttribute("orderForm");
//        System.out.println(orderForm.getOrder().toString());
        
        System.out.println(session.getAttribute("userSession").toString());
        System.out.println(orderForm.getOrder().toString());
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("item_name", "갤럭시S9");
        params.add("quantity", "1");
        params.add("total_amount", "2100");
        params.add("tax_free_amount", "100");
        params.add("approval_url", "/usStore/shop/kakaoPaySuccess.do");
        params.add("cancel_url", "/usStore/shop/kakaoPayCancel.do");
        params.add("fail_url", "/usStore/shop/kakaoPaySuccessFail.do");
      
//        params.add("cid", "TC0ONETIME");
//        params.add("partner_order_id", "1001");
//        params.add("partner_user_id", "gorany");
//        params.add("item_name", orderForm.getOrder().getItemName());
//        params.add("quantity", String.valueOf(orderForm.getOrder().getTotalQuentity()));
//        params.add("total_amount", String.valueOf(orderForm.getOrder().getTotalPrice()));
//        params.add("tax_free_amount", "100");
//        params.add("approval_url", "/usStore/shop/kakaoPaySuccess.do");
//        params.add("cancel_url", "/usStore/shop/kakaoPayCancel.do");
//        params.add("fail_url", "/usStore/shop/kakaoPaySuccessFail.do");
// 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
         System.out.println(body.toString());
        try {
        	
            kakaoPayReady = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReady.class);
            
            log.info("" + kakaoPayReady);
            
            return kakaoPayReady.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        System.out.println(kakaoPayReady.getNext_redirect_pc_url());
        
        return kakaoPayReady.getNext_redirect_pc_url();
    }
    
    public KakaoPayApproval kakaoPayInfo(String pg_token) {
    	 
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "2d2343b15ecc5bce081443419956cef3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReady.getTid());
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("pg_token", pg_token);
        params.add("total_amount", "2100");
//        params.add("total_amount", String.valueOf(orderForm.getOrder().getTotalPrice()));
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApproval = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApproval.class);
            log.info("" + kakaoPayApproval);
          
            return kakaoPayApproval;
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return null;
    }
}