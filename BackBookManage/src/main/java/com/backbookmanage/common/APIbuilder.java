package com.backbookmanage.common;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class APIbuilder {
	public static String apibuilder(StringBuilder url) {
		String responseCode = "";
        String responseBody = "";
        
//       StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx");
//	    urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=key"); // 서비스키
//	    urlBuilder.append("&" + URLEncoder.encode("Query", "UTF-8") + "=" + URLEncoder.encode(inputSearch, "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("MaxResults", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("start", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));

        // Create an HttpClient instance (Java 11+)
        HttpClient client = HttpClient.newHttpClient();

        // Create an HttpRequest object
        HttpRequest apiRequest = HttpRequest.newBuilder()
                .uri(URI.create(url.toString())) // Set the request URL
                .header("Content-Type", "application/json") // Set header (we expect XML response)
                .build();
        
        try {
            // Send the request and get the response
            HttpResponse<String> apiResponse = client.send(apiRequest, HttpResponse.BodyHandlers.ofString());

            // Store the response code and body
            responseCode = String.valueOf(apiResponse.statusCode());
            responseBody = apiResponse.body();

            // Log the response for debugging
            System.out.println("API Response Code: " + responseCode);
            System.out.println("API Response Body: " + responseBody);

            // 상태 코드가 200이 아닌 경우 예외 처리
            if (apiResponse.statusCode() != 200) {
                throw new Exception("API 호출 실패: " + apiResponse.statusCode() + " - " + apiResponse.body());
            } else {
            	return responseBody;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("API 호출 실패: " + e.getMessage());
        }
        return null;
	}

}
