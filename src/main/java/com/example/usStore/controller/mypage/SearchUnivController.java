package com.example.usStore.controller.mypage;

import com.example.usStore.domain.Item;
import com.example.usStore.domain.University;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SearchUnivController<jsonnode> {
	
	static String urlstr;
	
	/** Json 데이터 파싱을 위한 매퍼 정의  */ 
	private static final ObjectMapper MAPPER = new ObjectMapper();
	
	@RequestMapping("/searchUniv.do")
	public String handleRequest() throws Exception {
		
		return "account/searchUniv";  //외부 api 쓰는 팝업창 보여주기 
	}
	
	@RequestMapping("/api/university.do")
	public String findUniversity(@ModelAttribute SearchUniversity searchUniv,
			Model model) throws Exception {

		String region = searchUniv.getRegion();
		String searchSchulNm = searchUniv.getUnivName();
		//ArrayList<String> results = new ArrayList<String>(); // 대학교 검색 결과 여러개 담

		int regionCode = UnivRegionEnum.getCode(region);
		System.out.println(regionCode + " : " + searchSchulNm);
		if (regionCode == -1) { //선택하세요 클릭 시에 리다이렉트 해주기 
			return "redirect:/searchUniv.do";
		}
		
		//open api 사용 
		urlstr = "http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=64d783f84c56facec82aef2ec57357ee&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list&region=100260&searchSchulNm=동";

		//parsing();
//		Item items = new ItemList(); // 응답 결과 담는 리스트 ??? ㄱre 
//		 
//		try {
//			URL url = new URL(urlstr);
//			URLConnection connection = url.openConnection();
//			InputStream is = connection.getInputStream();
//			JsonNode jn = MAPPER.readTree(is);
//			JsonNode jn2 = jn.get("dataSearch").get("content");
//			
//			Iterator<JsonNode> iter = jn2.elements();
//			List<University> list = new ArrayList<University>();
//			while(iter.hasNext()){
//			    JsonNode jn3 = iter.next();
//			    if(items.getTotalCount() == 0 )
//			        (items.setTotalCount(jn3.get("totalCount").asInt());    
//			    list.add(new University(
//			      jn3.get("schoolName").textValue(),
//			      jn3.get("link").textValue(),
//			      jn3.get("adres").textValue()
//			      ));
//		} catch (Exception e) {
//			System.out.println(e);
//		}
//		
		//model로 가는 결과가 여러개인것을 주의하자
		// list로 결과 보내서 select로?? 선택할수 있게 결과 띄어주기 
		model.addAttribute("result", "동덕여자대학교");
		return "account/searchUniv";  //외부 api 쓰는 팝업창 (대학교 이름 결과 보내주기)
	}
//	
//	private static String readUrl() throws Exception {
//		  
//	        BufferedInputStream reader = null;
//	        try {
//	        	System.out.println(urlstr);
//	            URL url = new URL(urlstr);
//	        
//	            reader = new BufferedInputStream(url.openStream());
//	            StringBuffer buffer = new StringBuffer();
//	            int i;
//	            byte[] b = new byte[4096];
//	            while( (i = reader.read(b)) != -1){
//	              buffer.append(new String(b, 0, i));
//	            }
//	            System.out.println("readUrl() : " + buffer.toString());
//	            return buffer.toString();
//	        } finally {
//	            if (reader != null)
//	                reader.close();
//	        }
//	    }
//	
//		private void parsing() throws ParseException, Exception {
//			
//			System.out.println("parsing 메소드 진입");
//			
//	        JSONParser jsonparser = new JSONParser();
//	        JSONObject jsonobject = (JSONObject)jsonparser.parse(readUrl()); // Json 객체로 만들어줌 
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
//		
		
//		private void parsing2() throws UnsupportedEncodingException, IOException {
//			/* 공통부분 */
//			URL url = new URL(urlstr);
//			InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
//			JSONObject object = (JSONObject)JSONValue.parse(isr);
//			System.out.println("object: " + object);
//
//			JSONObject dataSearch = (JSONObject) object.get("dataSearch");
//			System.out.println("dataSearch: " + dataSearch);
//			
//			JSONArray content = (JSONArray) dataSearch.get("content");
//			for(int i = 0 ; i < content.size(); i++) 
//			{
//				JSONObject data = (JSONObject) content.get(i);        
//				System.out.println(data.get("schoolName").toString());
//			}
//
//		}
		
}
