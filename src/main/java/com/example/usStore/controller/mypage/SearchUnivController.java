package com.example.usStore.controller.mypage;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.sun.xml.messaging.saaj.packaging.mime.internet.ParseException;

@Controller
public class SearchUnivController {

	private static RestTemplate restTemplate = new RestTemplate();
	private static List<String> schNameList = null;

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
	
		System.out.print("sss: " + searchSchulNm);
		if(searchSchulNm == "") {
			return "redirect:/searchUniv.do";
		}
		
		String uri = "http://www.career.go.kr/cnet/openapi/getOpenApi?"
				+ "apiKey=64d783f84c56facec82aef2ec57357ee&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list"
				+ "&searchSchulNm="+searchSchulNm;
		
		if (regionCode != -1) { // 지역 선택했을 때,, 
			uri += "&region="+regionCode;
		}
		
		//open api 요청
		String body = restTemplate.getForObject(uri, String.class);
	//	System.out.println("body : " + body);
		
		parsing(body);
		if (schNameList != null) {  //null이면 result란 객체가 없는거????? 다시 생각하기 
			model.addAttribute("results", schNameList);
			return "account/searchUniv";
		}else {
			System.out.println("결과가 없다...");
			return "redirect:/searchUniv.do";
		}

//		DataSearch data = restTemplate.getForObject(uri, DataSearch.class);
//		System.out.println(data.toString()); //리스트를 아예 못읽어옴 
//		System.out.println(dataSearch.getContents());
		
	}

	@RequestMapping("/confirmUnivName.do")
	public String handleRequest2() throws Exception {
		
		
		return "account/searchUniv";  // 수정하기 : 에딧 인지 회원가입인지 구분해서 그 페이지에 대학교이름 완전 박아두기 
		// 나중에 REGISTER 버튼 누르면 그때 실질적으로 디비에 대학교 도메인객체가 들어가게된다. 
	}
	
	
	
	
	
	private static void parsing(String result) throws ParseException, Exception {

			System.out.println("parsing 메소드 진입");

			JSONParser jsonparser = new JSONParser();
	        JSONObject jsonobject = (JSONObject)jsonparser.parse(result); // Json 객체로 만들어줌
	       // System.out.println("jsonobject : " + jsonobject.toJSONString());

	        JSONObject dataSearch =  (JSONObject) jsonobject.get("dataSearch");
	       // System.out.println("dataSearch : "  + dataSearch.toJSONString());

	        JSONArray content = (JSONArray)dataSearch.get("content");
	      //  System.out.println("content : " + content.toJSONString());

	        schNameList = new ArrayList<String>();
	        
	        for(int i = 0 ; i < content.size(); i++){
	            JSONObject entity = (JSONObject)content.get(i);
	            String schoolName = (String) entity.get("schoolName");
	            System.out.println("학교 이름 결과 : " + schoolName);
	            schNameList.add(schoolName);
	        }

		}


}
