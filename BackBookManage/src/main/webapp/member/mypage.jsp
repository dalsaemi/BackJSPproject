<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<% 
	request.setCharacterEncoding("UTF-8");
	RequestDispatcher dispatcher = request.getRequestDispatcher("/readMember.do");
	dispatcher.include(request, response);
	
	// memberInfo를 안전하게 가져오기
    ArrayList<String> memberInfo = (ArrayList<String>) request.getAttribute("memberInfo");
    if (memberInfo == null) {
        memberInfo = new ArrayList<>();
    }
    String member_id = memberInfo.get(0);
    String member_name = memberInfo.get(1);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/mypage.css">
    <script type="text/javascript">
    function memberDeleteForm(){
    	if(confirm("정말 탈퇴하시겠습니까? 확인 버튼 선택 시, 계정은 삭제되며 복구되지 않습니다.")){
    		var memberDelete = document.deleteForm;
    		var member_id = memberDelete.member_id.value;
    		var fowardURL = memberDelete.fowardURL.value;
    		var mappingPath = memberDelete.mappingPath.value;
    		//회원 탈퇴
    		memberDelete.method = "post";
    		memberDelete.action = mappingPath+"/memberDelete.do";
    		memberDelete.submit();
    	    alert("탈퇴 처리되었습니다.");
    	    return true;
    	}else{
    	    alert("탈퇴가 취소되었습니다.");
    	    return false;
    	}
    }
    </script>
</head>
<body>
    <div class="container">
        <!-- 사이드바 -->
        <nav class="sidebar">
            <h2 class="site-name"><a href="<%=request.getContextPath()%>/index.jsp">웹사이트 이름</a></h2>
            <ul class="menu">
                <li><a href="<%=request.getContextPath()%>/myrecordpage.jsp">나의 독서 기록</a></li>
                <li><a href="#">자주 가는 도서관</a></li>
                <li><a href="<%=request.getContextPath()%>/bookinfo/getRecord.jsp">작성 글 모아보기</a></li>
                <li><a href="#">즐겨찾기 목록</a></li>
                <li><a href="#" class="active">회원정보 및 계정 관리</a></li>
            </ul>
        </nav>

        <div class="main-content">
            <header>
                <h1>회원정보 및 계정 관리</h1>
            </header>

            <section class="user-profile">
                <div class="profile-header">
                    <div class="profile-img">
                        <span></span>
                    </div>
                    <div class="profile-info">
                        <h2><%= member_name %></h2> <!-- 회원 이름 -->
                        <p>안녕하세요.</p>
                    </div>
                </div>
            </section>

            <section class="user-details">
                <div class="details-section">
                    <h3>회원 정보</h3>
                    <table>
                        <tr>
                            <td>이름</td>
                            <td><%= member_name %></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td><%= memberInfo.get(3) %></td>
                        </tr>
                        <tr>
                            <td>생년월일</td>
                            <td><%= memberInfo.get(4) %></td>
                        </tr>
                        <tr>
                            <td>성별</td>
                            <td><%= memberInfo.get(6) %></td>
                        </tr>
                        <tr>
                            <td>아이디</td>
                            <td><%= member_id %></td>
                        </tr>
                    </table>
                </div>

                <div class="details-section">
                    <h3>계정 관리</h3>
                    <ul>
                        <li><a href="<%=request.getContextPath() %>/member/memberPasswordUpdate.jsp">회원정보 변경</a></li>
                        <li><a href="#">비밀번호 변경</a></li>
                        <li><a href="#">로그아웃</a></li>
                        <li><a href="#">계정 탈퇴</a></li>
                        <li><a href="<%=request.getContextPath() %>/member/memberPasswordUpdate.jsp">비밀번호 변경</a></li>
                        <form action="<%=request.getContextPath() %>/logout.do" method="get">
					        <button type="submit">로그아웃</button>
					   	</form>
					   	<form name="deleteForm" action="<%=request.getContextPath() %>/memberDelete.do" method="post">
					   		<input type="hidden" name="mappingPath" value="<%=request.getContextPath() %>">
					   		<input type="hidden" name="member_id" value="<%=member_id%>">
					   		<input type="hidden" name="fowardURL" value="index.jsp">
					        <input type="button" onClick="return memberDeleteForm()" value="계정 탈퇴">
					   	</form>
                    </ul>
                </div>
            </section>
        </div>
    </div>
</body>
</html>



