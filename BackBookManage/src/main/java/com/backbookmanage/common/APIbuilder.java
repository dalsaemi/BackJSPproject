package com.backbookmanage.common;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class APIbuilder {
	// 매개변수로 받은 URL을 기반으로 HTTP 요청을 보내고 응답 결과를 반환하는 메소드
	public static String apibuilder(StringBuilder url) {
		String responseCode = ""; // 응답 상태 코드
        String responseBody = ""; // 응답 본문

        HttpClient client = HttpClient.newHttpClient();
        // URL 및 헤더 정보 설정
        HttpRequest apiRequest = HttpRequest.newBuilder()
                .uri(URI.create(url.toString())) 
                .header("Content-Type", "application/json") 
                .build();
        
        try {
        	// API 요청 전송 및 응답 받기
            HttpResponse<String> apiResponse = client.send(apiRequest, HttpResponse.BodyHandlers.ofString());
            // 응답 상태 코드 및 본문 가져오기
            responseCode = String.valueOf(apiResponse.statusCode());
            responseBody = apiResponse.body();

            if (apiResponse.statusCode() != 200) {
                throw new Exception("API 호출 실패: " + apiResponse.statusCode() + " - " + apiResponse.body());
            } else {
            	return responseBody; // 상태 코드가 200이면 응답 본문 반환
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("API 호출 실패: " + e.getMessage());
        }
        return null;
	}
}
