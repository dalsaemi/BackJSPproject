<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 웹사이트</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/index_styles.css">
<%
	request.setCharacterEncoding("UTF-8");
    // 세션에서 로그인 상태를 확인합니다.
    HttpSession callSession = request.getSession();
    String member_id = (String) callSession.getAttribute("member_id"); // 로그인 시 저장된 사용자 이름
%>
</head>
<body>
<main>
        <%@ include file="main/header.jsp" %>
        
        <!--banner-->
        <div class="banner"></div>

        <!--main-content-->
        <div class="main-content">
            <!--login-->
	                <%
					    if (member_id == null) {
					        // 로그인 상태가 아닐 경우 로그인 폼 표시
					%>
					    <div class="login">
					        <h2>로그인</h2>
					        <form method="post" action="<%= request.getContextPath() %>/login.do">
					            <input type="text" id="username" name="member_id" placeholder="사용자 아이디" required>
					            <input type="password" id="password" name="member_password" placeholder="비밀번호" required>
					            <button type="submit">로그인</button>
					            <div id="idpass">
					                <label id="remember">
					                    <input type="checkbox" name="rememberMe"> 아이디 저장
					                </label>
					                <a href="#" id="forget">아이디/비밀번호 찾기</a>
					            </div>
					        </form>
					        <button class="signup" onclick="window.location.href='<%= request.getContextPath() %>/member/Register.jsp';">회원가입</button>
					    </div>
					<%
					    } else {
					        // 로그인 상태일 경우 환영 메시지 표시
					        boolean isManager = (Boolean) session.getAttribute("is_manager");
					%>
					    <div class="welcome">
					        <h2><%= member_id %>님, 환영합니다</h2>
					        <p>서울도서관</p>
					        <p>최근 읽은 책: 꽃을 보듯 너를 본다</p>
					        <p>최근 독서 기록: 푸른 사자 와니니</p>
					        <button onclick="window.location.href='record.jsp'">기록하러 가기</button>
						<% if (isManager) { %>
					        <button onclick="window.location.href='<%= request.getContextPath() %>/member/adminpage.jsp'">관리자페이지</button>
						<% } else { %>
							<button onclick="window.location.href='<%= request.getContextPath() %>/member/mypage.jsp'">마이페이지</button>
						<%
							} 
						%>
					        <form action="logout.do" method="get">
					        	<button type="submit">로그아웃</button>
					   		</form>
					    </div>
					<%
					    }
					%>
            <!--book-section-->
            <%@include file="main/book_section.jsp" %>
            
        </div>
        <!--info-section-->
        <div class="info-section">
            <!--announcements-->
            <section class="announcements-faq">
                <button>공지사항</button>
                <button>자주 묻는 질문</button>
                <ul>
                    <li>공지사항 1 <span>2024-09-10</span></li>
                    <li>공지사항 2 <span>2024-09-15</span></li>
                    <li>공지사항 3 <span>2024-09-16</span></li>
                    <li>공지사항 4 <span>2024-09-17</span></li>
                    <li>공지사항 5 <span>2024-09-18</span></li>
                    <li>공지사항 6 <span>2024-09-19</span></li>
                </ul>
            </section>
            <!--faq-->
            <!-- <section class="faq">
                <h3>자주 묻는 질문</h3>
                <ul>
                    <li>Q. 도서관 등록은 어떻게 하나요?</li>
                    <li>Q. 프론트엔트와 백엔드, 당신의 선택은?</li>
                    <li>Q. 기록 수정은 어떻게 하나요?</li>
                </ul>
            </section> -->
            <!--customer-support-->
        
            <div id="etc">
                <section class="customer-support">
                    <h3>고객센터</h3>
                    <p>문의사항이 있으신가요?</p>
                </section>
                <!--library-registration-->
                <section class="library-registration">
                    <h3>도서관 등록</h3>
                    <p>자주 방문하는 도서관을 등록하세요!</p>
                </section>
            </div>
        </div> 
    </main>
    <!-- 메인 콘텐츠 끝 -->

    <%@include file="main/footer.jsp" %>
    <!-- 푸터 끝 -->
</body>
</html>