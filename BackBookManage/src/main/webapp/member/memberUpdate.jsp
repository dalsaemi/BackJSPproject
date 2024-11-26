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
	
    function validateForm() {
        const password = document.querySelector('input[name="member_password"]').value;
        const confirmPassword = document.querySelector('input[name="member_password_confirm"]').value;
        
        if (password.length < 8 || password.length > 20) {
        	alert("비밀번호를 8~20자로 입력해주세요.");
            return false;
        }
        
        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        alert("회원 정보 수정이 완료되었습니다.");
        return true;
    }
    
</script>
</head>
<body>
    <h3>회원 정보 수정</h3>
    <form method="POST" action="memberUpdateaction.do" onsubmit="return validateForm()">
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
            <!-- 암호 -->
            <tr>
                <th>암호</th>
                <td>
                    <input type="password" name="member_password" placeholder="새 암호 입력">
                </td>
            </tr>
            <tr>
                <th>암호 확인</th>
                <td>
                    <input type="password" name="member_password_confirm" placeholder="암호 다시 입력">
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
