package com.example.usStore.controller.order;

import java.net.URI;
import java.net.URISyntaxException;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import com.example.usStore.domain.KakaoPayApproval;
import com.example.usStore.domain.KakaoPayReady;
import lombok.extern.java.Log;
 
@Service
@Log
@SessionAttributes("orderForm")
public class KakaoPayService {
 
    private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReady kakaoPayReady;
    private KakaoPayApproval kakaoPayApproval;
    private String total_amount;

    public String kakaoPayReady(HttpSession session, OrderForm orderForm) {
 
        RestTemplate restTemplate = new RestTemplate();
 
        System.out.println("kakaopayReady");
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "2d2343b15ecc5bce081443419956cef3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        System.out.println(session.getAttribute("userSession").toString());
        System.out.println(orderForm.getOrder().toString());
        
        String item_name = orderForm.getOrder().getItemName();
        String quantity = String.valueOf(orderForm.getOrder().getTotalQuentity());
        total_amount  = String.valueOf((int)orderForm.getOrder().getTotalPrice());
        
        System.out.println("print : " + item_name + " " + quantity + " " + total_amount);
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "partner_order_id");
        params.add("partner_user_id", "partner_user_id");
        params.add("item_name", item_name);
        params.add("quantity", quantity);
        params.add("total_amount", total_amount);
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:8089/usStore/shop/kakaoPaySuccess.do");
        params.add("cancel_url", "http://localhost:8089/usStore/shop/kakaoPayCancel.do");
        params.add("fail_url", "http://localhost:8089/usStore/shop/kakaoPaySuccessFail.do");

        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        System.out.println("params : " + body.toString());
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
        params.add("partner_order_id", "partner_order_id");
        params.add("partner_user_id", "partner_user_id");
        params.add("pg_token", pg_token);
        params.add("total_amount", total_amount);
        
        System.out.println("params: " + params.toString());
        
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