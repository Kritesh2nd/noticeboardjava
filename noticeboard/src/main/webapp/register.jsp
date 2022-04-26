<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.*,java.util.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "notice";
String userid = "root";
String password = "";
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
String btn = request.getParameter("button");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Notice Board | Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .mainbody{height:100vh;}
      .box1{font-size:22px;text-align: center;padding:20px;color: #fff;background: #2a2a2a;}
      .box2{flex-grow: 1;}
      .form{padding:25px;border-radius:3px;width:350px;}
      .formtitle{font-size:26px;text-align:center;}
      .formtxt0{font-size:18px;padding:10px 0 5px 0;}
      .inpbox0{width:100%;font-size:18px;padding:5px 7px;border-radius:3px;}
      .formtxt3{padding:5px 0 5px 0;}
      .formmsg1{font-size:15px;padding:5px 0 0 0;}
      .btnbox1{padding-top:10px;}
      .submitbtn{background:#007bff;color:#fff;padding:10px 20px;border-radius:3px;border:none;font-size:17px;cursor:pointer;}
      .btnbox2{padding-top:10px;}
      .formtxt4{padding:0 20px 0 0;}
      .ahrlink{color: #000;}
      .formoptionbox{padding:15px 0 0 0;width:100%;}
      .classoptionbox{font-size:16px;padding:0;width:100px;height:30px;text-align:center;}
      .classoptions{border:1px solid #000;}
      .foptmsg{padding:0 0 0 20px;font-size:15px;}
      .formmsgbox{padding-top:5px;}
    </style>
  </head>
  <body>
    <div class="mainbody flex fdc">
      <div class="box1 borde">
          Online Notice System
      </div>
      <div class="box2 borde flex aic jcc">
        <form action="register.jsp" method="POST" class="form border">
          <div class="formtitle">Register</div>
          <div class="formtxt1 formtxt0">Name</div>
          <input type="text" class="inpbox1 inpbox0 border" name="name">
          <div class="formtxt1 formtxt0">Email</div>
          <input type="text" class="inpbox2 inpbox0 border" name="email">
          <div class="formmsg1 formtxt0 borde">
            <%
              boolean registertrue = false;
              if(btn!=null){
                if(btn.equals("Register")){
                  registertrue = true;
                } 
              }
              String inpname = request.getParameter("name");
              String inpemail = request.getParameter("email");
              String inppassword = request.getParameter("password");
              String inpclass = request.getParameter("classoption");
              String tblemail="";
              boolean inputempty=true,emailregister=false,selectclassempty=false;
//              out.print("Name = "+inpname+"<br/>Email = "+inpemail+"<br/>Password = "+inppassword+"<br/>Class = "+inpclass+"<br/>");
              try{
              String sql;
              Class.forName("com.mysql.jdbc.Driver");  
              connection = DriverManager.getConnection(connectionUrl+database, userid, password);
              statement=connection.createStatement();
              sql = "select * from userinfo";
              resultSet = statement.executeQuery(sql);
              while(resultSet.next()&&emailregister==false){
                tblemail = resultSet.getString("email");
                if(tblemail.equals(inpemail)){
                    emailregister=true;
                }
//                out.print("tblemail="+tblemail+", emailregister="+emailregister+"<br/>");
              }
              if(inpname!=null&&inpemail!=null&&inppassword!=null&&inpclass!=null){
                if(!inpname.equals("")&&!inpemail.equals("")&&!inppassword.equals("")&&!inpclass.equals("null")){
                    inputempty=false;
                }
              }
              if(inpemail!=null){
                selectclassempty=true;
              }else{
                selectclassempty=false;
              }
//              out.print("inputempty="+inputempty+", emailregister="+emailregister);
              if(inputempty==false&&emailregister==false){
                sql = "insert into userinfo(name,email,password,class,utype)values('"+inpname+"','"+inpemail+"','"+inppassword+"',"+inpclass+",'user');";
                statement.executeUpdate(sql);
                session.setAttribute("uemail",inpemail);
                response.sendRedirect("index.jsp");
              }
              if(emailregister){
                  out.print("This email is already in use");
              }
              connection.close();
              }catch(Exception ex) {
              System.out.println(ex.toString());
              }
            %>
          </div>
          <div class="formtxt3 formtxt0">Password</div>
          <input type="text" class="inpbox3 inpbox0 border" name="password">
          <div class="formoptionbox borde flex">
            <div class="formtxt4 formtxt0 borde flex aic">
              Class
            </div>
            <select class="classoptionbox border" name="classoption">
              <option class="classoptions" value=null>N/A</option>
              <option class="classoptions" value="1">1</option>
              <option class="classoptions" value="2">2</option>
              <option class="classoptions" value="3">3</option>
              <option class="classoptions" value="4">4</option>
              <option class="classoptions" value="5">5</option>
              <option class="classoptions" value="6">6</option>
              <option class="classoptions" value="7">7</option>
              <option class="classoptions" value="8">8</option>
              <option class="classoptions" value="9">9</option>
              <option class="classoptions" value="10">10</option>
              <option class="classoptions" value="11">11</option>
              <option class="classoptions" value="12">12</option>
            </select>
            <div class="foptmsg borde none">
                         
            </div>
          </div>
          <div class="formmsgbox borde">
            <%
              if(inputempty==true && registertrue==true){
                out.print("Please fill in all boxes.");
              }
              else if(inputempty==false&&emailregister==false&&registertrue==true){
                  out.print("Successfully registered");
                  
              }
            %>  
          </div>
          <div class="btnbox1 borde">
            <input type="submit" class="submitbtn w100" value="Register" name="button">
          </div>
          <div class="btnbox2 flex jcc">
            <a href="login.jsp" class="ahrlink ">
              Go to Log In
            </a>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>