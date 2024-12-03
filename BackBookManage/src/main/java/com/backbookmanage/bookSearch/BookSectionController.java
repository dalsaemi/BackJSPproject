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
 * Servlet implementation class BookSectionController
 */
@WebServlet("/bookSection.do")
public class BookSectionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String apikey = Config.API_KEY;
	String query;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String command = request.getParameter("bookSection");
		if (command == null || command.isEmpty()) {
			command = "new";
		}
		
		if (command.equals("new")) {
			query = "ItemNewSpecial";
		} else if (command.equals("bestBook")) {
			query = "Bestseller";
		}
		
		StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemList.aspx");
        urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=" + URLEncoder.encode(apikey, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("QueryType", "UTF-8") + "=" + URLEncoder.encode(query, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Start", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("MaxResults", "UTF-8") + "=" + URLEncoder.encode("4", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("SearchTarget", "UTF-8") + "=" + URLEncoder.encode("Book", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Cover", "UTF-8") + "=" + URLEncoder.encode("MidBig", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("Version", "UTF-8") + "=" + URLEncoder.encode("20131101", "UTF-8"));
	    
	    String result = APIbuilder.apibuilder(urlBuilder);
	    
	    if (result != null) {
	    	request.setAttribute("responseBody", result);
	    }
	    else {
	    	request.setAttribute("responseBody", null);
	    }
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}


}
