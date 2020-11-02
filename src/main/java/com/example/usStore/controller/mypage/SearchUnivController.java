package com.example.usStore.controller.mypage;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.example.usStore.domain.University;
import com.example.usStore.service.facade.MyPageFacade;
import com.sun.xml.messaging.saaj.packaging.mime.internet.ParseException;

@Controller
public class SearchUnivController {

	private static RestTemplate restTemplate = new RestTemplate();
	private static List<University> schNameList = null;
	// DTO 객체
	private static University university = null;

	@Autowired
	MyPageFacade myPageFacade;
	
	@RequestMapping("/searchUniv.do")
	public String handleRequest() throws Exception {
		return "account/searchUniv";  //외부 api 쓰는 팝업창 보여주기 
	}
	
	@RequestMapping("/api/university.do")
	public String findUniversity(@ModelAttribute SearchUniv searchUniv,
			Model model) throws Exception {

		String region = searchUniv.getRegion();
		String searchSchulNm = searchUniv.getUnivName();
		int regionCode = UnivRegionEnum.getCode(region);
	
		if(searchSchulNm == "") {
			return "redirect:/searchUniv.do";
		}
		
		String uri = "http://www.career.go.kr/cnet/openapi/getOpenApi?"
				+ "apiKey=64d783f84c56facec82aef2ec57357ee&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list"
				+ "&searchSchulNm="+searchSchulNm;
		
		if (regionCode != -1) { // 지역 선택했을 때
			uri += "&region="+regionCode;
		}
		
		//open api 요청
		String body = restTemplate.getForObject(uri, String.class);
		
		parsing(body);
		if (schNameList != null) { 
			model.addAttribute("results", schNameList);
			return "account/searchUniv";
		}else {
			System.out.println("결과가 없다");
			return "redirect:/searchUniv.do";
		}
	}

	private static void parsing(String result) throws ParseException, Exception {
		JSONParser jsonparser = new JSONParser();
        JSONObject jsonobject = (JSONObject)jsonparser.parse(result); // Json 객체로 만들어줌
        JSONObject dataSearch =  (JSONObject) jsonobject.get("dataSearch");
        JSONArray content = (JSONArray)dataSearch.get("content");
        schNameList = new ArrayList<University>();
        
        for(int i = 0 ; i < content.size(); i++){
            JSONObject entity = (JSONObject)content.get(i);
            String schoolName = (String) entity.get("schoolName");
            String link = (String)entity.get("link");
            String adres = (String)entity.get("adres");
            String region = (String)entity.get("region");
            
            //DTO 객체 생성 및 값을 저장 
            university = new University(schoolName,link,adres, region);
            System.out.println("변경 : " + university);
            schNameList.add(university);
        }		
	}
}
