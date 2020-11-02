package com.example.usStore.controller;


import java.io.File;
import java.util.HashMap;
import java.util.Map;



/**
 * SDK를 통해 받은 access token을 지정하시면
 * REST API를 테스트해 보실 수 있는 샘플입니다.
 * 푸시 알림 관련 API를 테스트하시려면 admin key 지정해야 합니다.
 */

public class kakaoTestMain {

    private static KakaoRestApiHelper apiHelper = new KakaoRestApiHelper();

    private final static String ADMIN_KEY = "2d2343b15ecc5bce081443419956cef3";
    private final static String APP_KEY = "0j1mkHNUQPRdVByouaBWLhFbq-seFOGa7R3KYQo9c00AAAF01UlPQw";
    
    public static void main(String[] args) throws InterruptedException {
        new kakaoTestMain().test();
    }

    /**
     * 테스트가 필요한 api 블럭만 주석을 풀고 테스트하세요.
     */
    public void test() {
        // access token 지정
        apiHelper.setAccessToken(APP_KEY);

        // 푸시 알림이나 유저 아이디 리스트가 필요할 때 설정 합니다. 
        // (디벨로퍼스 내에 앱설정 메뉴를 가시면 있습니다)
        apiHelper.setAdminKey(ADMIN_KEY);

        testUserManagement();
        testKakaoTalk();
        testPush();
    }

    public void testUserManagement() {

        Map<String, String> paramMap;

        /*
        // 앱 사용자 정보 요청 (signup 후에 사용 가능)
        apiHelper.me();
        */

        // 앱 연결
        // apiHelper.signup();

        /*
        // 앱 연결(파라미터)
        paramMap = new HashMap<String, String>();
        paramMap.put("properties", "{\"nickname\":\"test\"}");
        apiHelper.signup(paramMap);
        */

        // 앱 탈퇴
        //apiHelper.unlink();

        // 앱 로그아웃
        //apiHelper.logout();

        /*
        // 앱 사용자 정보 업데이트
        paramMap = new HashMap<String, String>();
        paramMap.put("properties", "{\"nickname\":\"test\"}");
        apiHelper.updatProfile(paramMap);
        */

        // 앱 사용자 리스트 요청
        //apiHelper.getUserIds();

        /*
        // 앱 사용자 리스트 요청 (파라미터)
        paramMap = new HashMap<String, String>();
        paramMap.put("limit", "100");
        paramMap.put("fromId", "1");
        paramMap.put("order", "asc");
        apiHelper.getUserIds(paramMap);
        */
    }

    public void testKakaoTalk() {

        // 카카오톡 프로필 요청
        apiHelper.talkProfile();
    }

    public void testPush() {

        Map<String, String> paramMap;

        // 파라미터 설명
        // @param uuid 사용자의 고유 ID. 1~(2^63 -1), 숫자가만 가능
        // @param push_type  gcm or apns
        // @param push_token apns(64자) or GCM으로부터 발급받은 push token
        // @param uuids 기기의 고유한 ID 리스트 (최대 100개까지 가능)

        // 푸시 알림 관련 API를 테스트하시려면 admin key 지정해야 합니다.

        /*
        // 푸시 등록
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        paramMap.put("push_type", "gcm");
        paramMap.put("push_token", "xxxxxxxxxx");
        paramMap.put("device_id", "");
        apiHelper.registerPush(paramMap);
        */

        /*
        // 푸시 토큰 조회
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        apiHelper.getPushTokens(paramMap);
        */

        /*
        // 푸시 해제
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        paramMap.put("push_type", "gcm");
        paramMap.put("push_token", "xxxxxxxxxx");
        apiHelper.deregisterPush(paramMap);
        */

        /*
        // 푸시 보내기
        paramMap = new HashMap<String, String>();
        paramMap.put("uuids", "[\"1\",\"2\", \"3\"]");
        apiHelper.sendPush(paramMap);
        */
    }
}
