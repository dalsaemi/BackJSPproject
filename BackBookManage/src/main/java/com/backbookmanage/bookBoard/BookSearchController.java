package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

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
		
        StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx");
        urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=" + URLEncoder.encode(apikey, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Query", "UTF-8") + "=" + URLEncoder.encode(inputSearch, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("MaxResults", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("start", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
	    
	    String result = APIbuilder.apibuilder(urlBuilder);
	    
	    if (result != null)
        // Add the response data to the request attributes
	    	request.setAttribute("responseBody", result);
	    else
	    	request.setAttribute("responseBody", null);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/BookSearch.jsp");
		dispatcher.forward(request, response);
	}
	
}
