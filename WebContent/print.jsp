<%@page import="java.util.ArrayList"%>
<%@page import="food.FoodVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

//위 데이터를 데이터 베이스에 넣기
Connection conn = null;			
Boolean connect = false;

ArrayList<FoodVO> list = new ArrayList<>();
	
try {	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
	
	String sql = "select * from food";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next()) {
		FoodVO vo = new FoodVO();
		vo.setName(rs.getString("name"));
		vo.setMenu(rs.getString("menu"));
		vo.setHome(rs.getString("home"));
		vo.setPrice(rs.getString("price"));
		vo.setLoc(rs.getString("loc"));
		vo.setStar(rs.getString("star"));
		vo.setTel(rs.getString("tel"));
		vo.setTime(rs.getString("time"));
		list.add(vo);
	}
	
	connect = true;
	conn.close();
} catch (Exception e) {	
	connect = false;
	e.printStackTrace();
}	
	
if (connect == true) {	
	System.out.println("연결되었습니다.");
} else {	
	System.out.println("연결실패.");
}	

%>    

<!DOCTYPE html>
<html>
<head>
  <title>맛집 리스트</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand/logo -->
  <a class="navbar-brand" href="index.jsp">4학사</a>
  
  <!-- Links -->
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="insert.jsp">맛집 추가</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="print.jsp">전체 맛집</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">맛집 추천</a>
    </li>
  </ul>
   <form class="form-inline" action="/action_page.php">
    <input class="form-control mr-sm-2" type="text" placeholder="Search">
    <button class="btn btn-success" type="submit">Search</button>
  </form>
</nav>

<div class="container">
  <h2>맛집 리스트</h2>
  <table class="table">
    <thead>
      <tr>
        <th>가게이름</th>
        <th>메뉴</th>
        <th>원산지</th>
        <th>가격</th>
        <th>위치</th>
        <th>별점</th>
        <th>전화번호</th>
        <th>영업시간</th>
      </tr>
    </thead>
    <tbody>
    <%for (FoodVO vo : list) { %>
      <tr class="table-dark text-dark">
        <td><%=vo.getName() %></td>
        <td><%=vo.getMenu() %></td>
        <td><%=vo.getHome() %> </td>
        <td><%=vo.getPrice() %></td>
        <td><%=vo.getLoc() %></td>
        <td><%=vo.getStar() %></td>
        <td><%=vo.getTel() %></td>
        <td><%=vo.getTime() %></td>
      </tr>      
  	<% } %>
    </tbody>
  </table>
</div>



</body>
</html>

    