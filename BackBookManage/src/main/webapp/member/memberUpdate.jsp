<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <script>
	let isCheck = false;
	
	function infoUpdateForm(){
		alert("회원 정보 수정이 완료되었습니다.");
	    return true;
	}
	</script>
</head>
<body>
    <h3>회원 정보 수정</h3>
    <form method="POST" action="<%= request.getContextPath() %>/memberUpdate.do" onsubmit="return infoUpdateForm()">
    	<!-- 비밀번호 넘기기 -->
        <input type="hidden" name="member_password" value="<%=memberInfo.get(2)%>">
        <table>
            <!-- 이름 -->
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" name="member_name" value="<%=memberInfo.get(1)%>">
                </td>
            </tr>
            <!-- 아이디 -->
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="member_id" value="<%=memberInfo.get(0)%>" readonly>
                </td>
            </tr>
            <!-- 이메일 -->
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" name="member_email" value="<%=memberInfo.get(3)%>">
                </td>
            </tr>
            <!-- 생일 -->
            <tr>
                <th>생일</th>
                <td>
                    <input type="date" class="text" name="member_birth" value="<%=memberInfo.get(4)%>">
                </td>
            </tr>
            <!-- 성별 -->
            <tr>
                <th>성별</th>
                <td>
                    <select name="member_gender" required>
		            	<option value="M" <%= "M".equals(memberInfo.get(6)) ? "selected" : "" %>>남성</option>
		            	<option value="W" <%= "W".equals(memberInfo.get(6)) ? "selected" : "" %>>여성</option>
	        		</select>
                </td>
            </tr>
        </table>
        <div class="form-actions">
            <input type="submit" value="수정하기">
            <input type="reset" value="취소" onClick="window.location.href='<%= request.getContextPath() %>/member/mypage.jsp';">
        </div>
    </form>
    
</body>
</html>
