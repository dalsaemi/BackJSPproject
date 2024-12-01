package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.common.APIbuilder;
import com.backbookmanage.common.Config;
/**
 * Servlet implementation class BookSearchServlet
 */
@WebServlet("/bookSearch.do")
public class BookSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String apikey = Config.API_KEY; 
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String inputSearch = request.getParameter("inputSearch");
		if (inputSearch == null || inputSearch.isEmpty()) {
			System.out.println("inputSearch 값이 null입니다.");
		    inputSearch = ""; // 기본값 설정
		}
		String maxResults = "10";
		String currentPage = request.getParameter("pageNo");
		if (currentPage == null) {
			currentPage = "1";
		}
		
        StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx");
        urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=" + URLEncoder.encode(apikey, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Query", "UTF-8") + "=" + URLEncoder.encode(inputSearch, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("start", "UTF-8") + "=" + URLEncoder.encode(currentPage, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("MaxResults", "UTF-8") + "=" + URLEncoder.encode(maxResults, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Sort", "UTF-8") + "=" + URLEncoder.encode("Accuracy", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
	    
	    String result = APIbuilder.apibuilder(urlBuilder);
	    
	    if (result != null && !result.isEmpty()) {
	        request.setAttribute("responseBody", result);
	        request.setAttribute("currentPage", currentPage);
	        request.setAttribute("maxResults", maxResults);
	    } else {
	    	System.out.println("api 호출 결과가 null입니다.");
	        request.setAttribute("responseBody", null);
	    }
	    
	    if (result != null) {
	    	request.setAttribute("inputSearch", inputSearch);
	    	request.setAttribute("responseBody", result);
	    	request.setAttribute("currentPage", currentPage);
	    	request.setAttribute("maxResults", maxResults);
	    }
	    else {
	    	request.setAttribute("responseBody", null);
	    }

		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/BookSearch.jsp");
		dispatcher.forward(request, response);
	}
	
}
