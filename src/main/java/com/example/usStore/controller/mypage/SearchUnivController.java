package com.example.usStore.controller.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Controller
public class SearchUnivController {

	private static RestTemplate restTemplate = new RestTemplate();

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
		System.out.println(regionCode + " : " + searchSchulNm);
		if (regionCode == -1) { //선택하세요 클릭 시에 리다이렉트 해주기 
			return "redirect:/searchUniv.do";
		}
		
		//open api 요청
		String uri = "http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=64d783f84c56facec82aef2ec57357ee&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list&region=100260&searchSchulNm=동덕";
		String body = restTemplate.getForObject(uri, String.class);
		System.out.println(body);


		DataSearch data = restTemplate.getForObject(uri, DataSearch.class);
		System.out.println(data.toString());
//		System.out.println(dataSearch.getContents());



		//model로 가는 결과가 여러개인것을 주의하자
		// list로 결과 보내서 select로?? 선택할수 있게 결과 띄어주기 
		model.addAttribute("result", "동덕여자대학교");
		return "account/searchUniv";  //외부 api 쓰는 팝업창 (대학교 이름 결과 보내주기)
	}

//		private static void parsing(String result) throws ParseException, Exception {
//
//			System.out.println("parsing 메소드 진입");
//
//			JSONParser jsonparser = new JSONParser();
//	        JSONObject jsonobject = (JSONObject)jsonparser.parse(result); // Json 객체로 만들어줌
//	        System.out.println("jsonobject : " + jsonobject.toJSONString());
//
//	        JSONObject dataSearch =  (JSONObject) jsonobject.get("dataSearch");
//	        System.out.println("dataSearch : "  + dataSearch.toJSONString());
//
//	        JSONArray content = (JSONArray)dataSearch.get("content");
//	        System.out.println("content : " + content.toJSONString());
//
//	        for(int i = 0 ; i < content.size(); i++){
//	            JSONObject entity = (JSONObject)content.get(i);
//	            String schoolName = (String) entity.get("schoolName");
//	            System.out.println("학교 이름 결과 : " + schoolName);
//	        }
//
//		}


}
