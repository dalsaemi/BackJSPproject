package com.backbookmanage.bookSearch;

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
 * Servlet implementation class BookSelectController
 */
@WebServlet("/bookSelect.do")
public class BookSelectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	String apikey = Config.API_KEY; 
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String bookId = request.getParameter("id");
		if (bookId == null || bookId.isEmpty()) {
			System.out.println("isbn 값이 null입니다.");
			bookId = "K142934245"; // 기본값 설정
		}

        StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx");
        urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=" + URLEncoder.encode(apikey, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("itemIdType", "UTF-8") + "=" + URLEncoder.encode("ISBN", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("ItemId", "UTF-8") + "=" + URLEncoder.encode(bookId, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Version", "UTF-8") + "=" + URLEncoder.encode("20131101", "UTF-8"));
	    
	    String result = APIbuilder.apibuilder(urlBuilder);
	    
	    if (result != null && !result.isEmpty()) {
	        request.setAttribute("responseBody", result);
	    } else {
	    	System.out.println("api 호출 결과가 null입니다.");
	        request.setAttribute("responseBody", null);
	    }
	    
	    if (result != null) {
	    	request.setAttribute("bookId", bookId);
	    }
	    else {
	    	request.setAttribute("bookId", null);
	    }

		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/modal.jsp");
		dispatcher.forward(request, response);
	}
}
