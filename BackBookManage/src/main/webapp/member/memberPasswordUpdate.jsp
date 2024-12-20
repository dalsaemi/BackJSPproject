<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>비밀번호 변경</title>
<script type="text/javascript">
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

    alert("비밀번호 수정이 완료되었습니다.");
    return true;
}
</script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberUpdate_styles.css?2">
</head>
<body>
		<div class="password-edit-container">
			<h3>비밀번호 변경</h3>
		    <form method="POST" action="<%= request.getContextPath() %>/memberUpdate.do" onsubmit="return validateForm()">
		    	<input type="hidden" name="member_name" value="<%=memberInfo.get(1)%>">
		    	<input type="hidden" name="member_id" value="<%=memberInfo.get(0)%>">
		    	<input type="hidden" name="member_email" value="<%=memberInfo.get(3)%>">
		    	<input type="hidden" name="member_birth" value="<%=memberInfo.get(4)%>">
		    	<input type="hidden" name="member_gender" value="<%=memberInfo.get(6)%>">
		        <table class ="input-table">
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
		        </table>
		        <div class="form-actions">
		            <input class="btn-submit" type="submit" value="수정하기">
		            <input class ="btn-cancel" type="reset" value="취소" onClick="window.location.href='<%= request.getContextPath() %>/member/mypage.jsp';">
		        </div>
		    </form>
		</div>
</body>
</html>