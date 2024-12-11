<%@ page import="com.backbookmanage.common.JDBCUtil,com.backbookmanage.member.DAO.MemberInformationDAO,java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독서 관리 서비스 회원가입</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/member/Register_styles.css">
</head>
<body>
<form method="get" action="<%=request.getContextPath()%>/register.do" onsubmit="return validateForm()">
    <table>
    <tr>
        <td><h2>회원가입</h2></td>
    </tr>
    <tr><td>아이디</td></tr>
    <tr><td><input type="text" class="text" name="member_id" placeholder="12자 이하로 작성해주세요" required></td></tr>
    <tr><td><input type="button" value="ID중복확인" onClick="idCheck()"></td></tr>
    <tr><td>비밀번호</td></tr>
    <tr><td><input type="password" class="text" name="member_password" placeholder="20자 이하로 작성해주세요" required></td></tr>
    <tr><td>비밀번호 확인</td></tr>
    <tr><td><input type="password" class="text" name="confirmPassword" required></td></tr>
    <tr><td>이름</td></tr>
    <tr><td><input type="text" class="text" name="member_name" required></td></tr>
    <tr><td>성별</td></tr>
	<tr>
	    <td>
	        <select name="member_gender" required>
	            <option value="M">남성</option>
	            <option value="W">여성</option>
	        </select>
	    </td>
	</tr>
    <tr><td>생년월일</td></tr>
    <tr><td><input type="date" class="text" name="member_birth" required></td></tr>
    <tr><td>이메일</td></tr>
    <tr>
        <td>
            <input id = "email" type="text" class="email" name="member_email" required> @ 
            <select name="domain">
                <option>naver.com</option>
                <option>gmail.com</option>
                <option>daum.net</option>
            </select>
        </td>
    </tr>
    <tr><td><input type="submit" value="회원가입" class="btn"></td></tr>
    </table>
</form>
<%
JDBCUtil.getConnection();
	MemberInformationDAO mDao = new MemberInformationDAO();
	ArrayList<String> members = mDao.memberIdList();
	// js에 넘겨주기 위한 사전작업
	StringBuffer values = new StringBuffer();
	for(int i=0; i < members.size(); i++) {
		if(values.length()>0) {
			values.append(',');
		}
		values.append('"').append(members.get(i)).append('"');
	}
%>
<script>
	let isCheck = false;
	
    function validateForm() {
        const password = document.querySelector('input[name="member_password"]').value;
        const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
        
        if (password.length < 8 || password.length > 20) {
        	alert("비밀번호를 8~20자로 입력해주세요.");
            return false;
        }
        
        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        
        if (!isCheck) {
        	alert("아이디 중복체크를 해주세요.");
        	return false;
        }
        alert("가입 완료! 환영합니다!");
        return true;
    }
    
    function idCheck() {
    	let id = document.querySelector('input[name="member_id"]').value;
    	let memberList = [<%= values.toString() %>];
    	// 아이디 입력칸이 빈칸일 경우
    	if(id.length < 6 || id.length > 12) {
    		alert("아이디를 6~12자로 입력해주세요.");
    		isCheck = false;
    		return;
    	}
    	// 아이디 중복 검사
    	for (let i = 0; i < memberList.length; i++) {
    		if (id == memberList[i]) {
    			alert("중복된 아이디입니다.");
				isCheck = false;
    			return false;
    		} 
    	}
    	
    	alert("사용 가능한 아이디입니다.");
    	isCheck = true; 		
    	return true;
    }
</script>
</body>
</html>