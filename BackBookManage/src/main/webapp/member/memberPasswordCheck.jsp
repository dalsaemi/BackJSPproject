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
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberUpdate_styles.css?2">
</head>
<body>
		<div class="password-edit-container">
			<h3>비밀번호 확인</h3>
		    <form method="POST" onsubmit="return checkPassword(event)" accept-charset="UTF-8">
		    	<input type="hidden" name="mode" value="password">
		    	<input type="hidden" name="member_id" value="<%=memberInfo.get(0)%>">
		        <table class ="input-table">
		            <tr>
		                <th>암호</th>
		                <td>
		                    <input type="password" name="member_password" placeholder="기존 암호 입력">
		                </td>
		            </tr>
		        </table>
		        <div class="form-actions">
		            <input class="btn-submit" type="submit" value="확인">
		            <input class ="btn-cancel" type="reset" value="취소" onClick="window.location.href='<%= request.getContextPath() %>/member/mypage.jsp';">
		        </div>
		    </form>
		</div>
		<script type="text/javascript">
		function checkPassword(event) {
		    event.preventDefault(); // 기본 폼 제출 방지
		    console.log("폼 제출이 방지되었습니다!");
		
		    const member_id = document.querySelector('input[name="member_id"]').value;
		    const member_password = document.querySelector('input[name="member_password"]').value;
		    
		    console.log("member_id: "+member_id);
		    console.log("member_password: "+member_password);

		    const requestBody = `member_id=`+member_id+`&member_password=`+member_password+`&mode=password`;
		    console.log("requestBody: " + requestBody);
		
		    fetch(`<%= request.getContextPath() %>/login.do`, {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: requestBody
		    })
		    .then(response => {
		        if (!response.ok) {
		            throw new Error("네트워크 응답에 문제가 있습니다.");
		        }
		        return response.json();
		    })
		    .then(data => {
		    	if (data && data.success !== undefined) {  // data와 success가 존재하는지 확인
		            if (data.success) {
		                window.location.href = '<%= request.getContextPath() %>/member/memberPasswordUpdate.jsp';
		            } else {
		                alert(data.message || "비밀번호가 틀렸습니다. 다시 입력해주세요.");
		            }
		        } else {
		            alert("서버 응답에 문제가 있습니다.");
		        }
		    })
		    .catch(error => {
		        alert("오류가 발생했습니다. 다시 시도해주세요.");
		        console.error(error);
		    });
		}
		
		document.addEventListener('DOMContentLoaded', function () {
		    document.querySelector("form").addEventListener("submit", checkPassword);
		});
		</script>
</body>
</html>