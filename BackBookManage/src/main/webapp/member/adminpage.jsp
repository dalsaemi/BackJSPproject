<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%	
  	// 컨트롤러 호출
  	request.setCharacterEncoding("UTF-8");
  	RequestDispatcher dispatcher = request.getRequestDispatcher("/listShow.do");
	dispatcher.include(request, response);

	ArrayList<String> members = (ArrayList<String>) request.getAttribute("members");
	if (members == null) {
	    members = new ArrayList<>();
	}
       
    // 회원 수 계산
    int memberCount = members.size();
    
 	// 선택된 회원의 정보 (아이디)
    String memberInfo = (String) request.getAttribute("memberInfos");
    String member_id = (String) request.getAttribute("member_id");
 %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main/header_styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/member/adminpage_styles.css?1">
</head>
<body>
	<header class="header">
        <div class="header-inner">
            <div class="logo"><a class = "index-title" href="<%=request.getContextPath() %>/index.jsp">웹사이트 이름</a></div>
            <!--menu-->
            <nav class="nav-links">
                <a href="<%=request.getContextPath() %>/member/adminpage.jsp">회원 관리</a>
                <a href="<%=request.getContextPath() %>/adminBoard.do">게시판 관리</a>
            </nav>
        </div>
    </header>
    <h2>회원 관리</h2>
    <p>회원 수: <%= memberCount %></p>

    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>마지막 로그인</th>
                <th>회원정보 및 관리</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (String member : members) {
                	dispatcher = request.getRequestDispatcher("/checkManager.do");
                	request.setAttribute("member_id", member);
                	dispatcher.include(request, response);
                	boolean isManager = (boolean) request.getAttribute("isManager");
            %>
            <tr>
                <td><%= member %></td>
                <td>2024-10-10 18:00</td>
                <td>
                    <% if (isManager) { %>
                    	<form method="post" action="<%= request.getContextPath() %>/addManage.do">
                        	<input type="hidden" name="member_id" value="<%= member %>">
                        	<input type="hidden" name="isManager" value="false">
                        	<input id="<%= member %>_admin" class="btn admin-btn" type="submit" value="관리자 권한 해제">
                    	</form>
                    <% } else { %>
                        <!-- 다중 클래스 적용~~ -->
                    	<form method="post" action="<%= request.getContextPath() %>/memberDelete.do">
                        	<input type="hidden" name="member_id" value="<%= member %>">
                        	<input id="<%= member %>_delete" class="btn delete-btn" type="submit" value="회원 삭제">
                    	</form>
                        
                        <form method="post" action="<%= request.getContextPath() %>/addManage.do">
                        	<input type="hidden" name="member_id" value="<%= member %>">
                        	<input type="hidden" name="isManager" value="true">
                        	<input id="<%= member %>_admin" class="btn admin-btn" type="submit" value="관리자 권한 부여">
                    	</form>
                    <% } %>
	                    <form method="get" action="<%= request.getContextPath() %>/memberSearch.do">
	                    	<input type="hidden" name="member_id" value="<%= member %>">
	                    	<input id="<%= member %>_read" class="btn" type="submit" value="회원 정보 열람">
	                    </form>
                    <% if (memberInfo != null && memberInfo != "" && member_id.equals(member)) { %>
					    <div class="member-info">
					        <p><%= memberInfo %></p>
					    </div>
				    <% }%>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <br>

    <script>
        function confirmDelete(memberId) {
            if (confirm(memberId + " 회원을 삭제하시겠습니까?")) {
                alert(memberId + " 회원이 삭제되었습니다.");
            }
        }
        
        function grantAdmin(memberId) {
            if (confirm(memberId + " 님에게 관리자 권한을 부여하시겠습니까?")) {
                alert(memberId + " 님에게 관리자 권한이 부여되었습니다.");
            }
        }

        function viewMemberInfo(){
        	var memberInfos = "<%= request.getAttribute("memberInfos")%>";
            if (memberInfos != null && memberInfos != "") {
                // 데이터가 있을 경우 처리
                alert("회원 정보: " + memberInfos);
            } else {
                alert("회원 정보를 찾을 수 없습니다.");
            }
        }
    </script>
</body>
</html>