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
ResultSet resultSet1 = null;
ResultSet resultSet2 = null;
%>
<%
    String sessemail = String.valueOf(session.getAttribute("uemail"));
    
    if(sessemail.equals("null")){
        response.sendRedirect("login.jsp");
//        out.print("user email = "+sessemail);
    }
    else if(!sessemail.equals("")){
    String optt = request.getParameter("opt");
    int pagenum = 1;
    if(optt==null){pagenum=1;}
    else if(optt.equals("notice")){pagenum=1;}
    else if(optt.equals("edit")){pagenum=2;}
    else if(optt.equals("logout")){pagenum=3;}
    else if(optt.equals("addnotice")){pagenum=4;}
    String logoutstr = request.getParameter("logout");
    if(logoutstr!=null){
      if(logoutstr.equals("yes")){
        session.removeAttribute("uemail");
        response.sendRedirect("index.jsp");
      }
    }
    String tblemail="",tblname="",tblutype="";
    int tbl_id=0;
    int tblclass=-1;
    boolean thisuser=false;
    try{
      Class.forName("com.mysql.jdbc.Driver");  
      connection = DriverManager.getConnection(connectionUrl+database, userid, password);
      statement=connection.createStatement();
      String sql ="select * from userinfo";
      resultSet = statement.executeQuery(sql);
      while(resultSet.next() && thisuser==false){
        tbl_id = resultSet.getInt("id");
        tblname = resultSet.getString("name");
        tblemail = resultSet.getString("email");
        tblclass = resultSet.getInt("class");
        tblutype = resultSet.getString("utype");
        if(sessemail.equals(tblemail)){
          thisuser=true;
        }
      }
      connection.close();
    }catch(Exception ex) {
      System.out.println(ex.toString());
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Notice Board | <%=tblname%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .mainbody{height:100vh;}
      .box1{font-size:22px;text-align: center;padding:20px;color: #fff;background: #2a2a2a;}
      .box2{flex-grow: 1;}
      .container1{width:24%;}
      .c1boxes{padding:8px 20px;}
      .c1box1{padding:20px 20px 0 20px;height:250px;overflow:hidden;}
      .imgbox{border-radius:3px;padding:10px;}
      .c1box2{padding:10px 20px;text-align: center;font-size:20px;}
      .c1box3{padding-top:10px;}
      .buttons{width:100%;border-radius:3px;padding:7px;text-align: center;font-size:20px;color:#000;text-decoration: none;
        transition:.3s;background:#fff;}
      .buttons:hover{background:#ccc;}
      .activebtn{background:#ccc;}

      .container2{width:76%;padding:20px;height:88vh;}
      .icontainer2{overflow:auto;}
      .subtitles{font-size:30px;text-align:center;padding:0px 0 15px 0;}
      .noticeboxnotice{padding:0px;margin-bottom:15px;border-radius:5px;}
      .nboxleft{width:65%;padding:15px;border-radius:3px;}
      .nboxright{width:33%;padding:15px;border-radius:3px;}
      .notice_title{font-size:26px;padding:5px 0px;}
      .notice_date{font-size:14px;padding:0;padding-bottom:5px;}
      .notice_content{font-size:18px;padding:0 0 10px 0;}
      .subtitleB{font-size:24px;padding-bottom:10px;}
      .icommentbox{max-height:200px;overflow:auto;}
      .minicommentbox{padding:5px;border-radius:5px;background:#ccc;margin-bottom:10px;}
      .cmt_owner{font-size:16px;font-weight:500;}
      .cmt_content{font-size:16px;}
      .inpcomment{font-size:16px;padding:5px 8px;border-radius:2px;flex-grow: 1;}
      .addcommentbox{padding-top:10px;}
      .btncomment{padding:5px 22px;border-radius:2px;font-size:16px;transition:.3s;margin-left:15px;background:#ccc;}
      .btncomment:hover{background:#aaa;cursor: pointer;}


      .profileedit{padding:15px;border-radius:5px;}
      .form{padding:25px;border-radius:3px;width:350px;}
      .formtitle{font-size:26px;text-align:center;}
      .formtxt0{font-size:18px;padding:10px 0 5px 0;}
      .inpbox0{width:100%;font-size:18px;padding:5px 7px;border-radius:3px;}
      .f2msg1{font-size:15px;padding:5px 0 0 0;}
      .formtxt3{padding:5px 0 5px 0;}
      .btnbox1{padding-top:10px;}
      .submitbtn{background:#007bff;color:#fff;padding:10px 20px;border-radius:3px;border:none;font-size:17px;cursor: pointer;}
      .btnbox2{padding-top:10px;}
      .formtxt4{padding:0 20px 0 0;}
      .ahrlink{color: #000;}
      .formoptionbox{padding:15px 0 0 0;width:100%;}
      .classoptionbox{font-size:16px;padding:0;width:100px;height:30px;text-align:center;}
      .classoptions{border:1px solid #000;}
      .foptmsg{padding:0 0 0 20px;font-size:15px;}
      .formmsgbox{padding-top:5px;}

      .logoutbox{padding:15px 20px 20px 20px;border-radius:5px;width:300px;}
      .logouttext{font-size:24px;text-align:center;padding-bottom:25px;}
      .btnyesno{padding:5px 20px;font-size:20px;border-radius:3px;background:#ccc;transition:.3s;}
      .btnyesno:hover{background:#aaa;cursor:pointer;}
      
      .addnotice{padding:15px;border-radius:5px;}
      .inpnotice{resize:none;width:100%;height:150px;font-size:18px;padding:10px;border-radius:3px;}
      .ckbxtxt0{font-size:18px;padding:0 5px;}
      .c0{height:20px;width:20px;border:1px solid #000;margin-right:10px;cursor:pointer;}
      .btnbox4{padding-top:15px;}
      .resetbtn{background:#dc3545;color:#fff;padding:10px 20px;border-radius:3px;border:none;font-size:17px;cursor: pointer;margin-left:10px;}
    </style>
  </head>
  <body>
    <div class="mainbody borde">
      <div class="imbody borde hw100 h100 flex fdc">
        <div class="box1 borde">
          Online Notice System
        </div>
        <div class="box2 borde flex h100">
          <div class="container1 border flex fdc">
            <div class="c1box1 c1boxes borde flex jcc">
              <img src="image/person.jpg" alt="" class="imgbox h100 border">
            </div>
            <div class="c1box2 c1boxes borde">
              <%=tblname%><br/>
              <%
                if(tblclass==0){out.print("");}
                else{out.print("Class "+tblclass);}
              %>
            </div>
            <%
              if(tblutype.equals("admin")){
            %>
              <div class="c1box3_1 c1boxes borde flex jcc">
                <a href="index.jsp?opt=addnotice" class="button1 buttons border">Add notice</a>
              </div>
            <%}%>
            <div class="c1box3 c1boxes borde flex jcc">
              <a href="index.jsp?opt=notice" class="button1 buttons border">Notice</a>
            </div>
            <div class="c1box4 c1boxes borde flex jcc">
              <a href="index.jsp?opt=edit" class="button1 buttons border">Profile Edit</a>
            </div>
            <div class="c1box5 c1boxes borde flex jcc">
              <a href="index.jsp?opt=logout" class="button1 buttons border">Log Out</a>
            </div>
            
          </div>
          <div class="container2 borde flex h100">
            <div class="icontainer2 borde hw100 w100">
              <%
                if(pagenum==1){
              %>
              <!-- ============================================== First Page ============================================== -->
              <div class="noticebox borde flex fdc">
                <div class="subtitles">
                  Notice Board
                </div>
                <%
                    String tblntitle="",tblncontent="",tbldatetime="";
                    String sql2;
                    int[] tblcarr = {0,0,0,0,0,0,0,0,0,0};
                     int noticeid[] =new int[100];
                    int a=1,count=0,tblid=0;
                    try{
                      Class.forName("com.mysql.jdbc.Driver");  
                      connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                      statement=connection.createStatement();
                      sql2 ="select * from notice";
                      resultSet = statement.executeQuery(sql2);
                      while(resultSet.next()){
                        tblid = resultSet.getInt("nid");
                        tblntitle = resultSet.getString("title");
                        tblncontent = resultSet.getString("content");
                        tbldatetime = resultSet.getString("datetime");
                        noticeid[count] = tblid;
                        for(a=1;a<=10;a++){
                            tblcarr[a-1] = resultSet.getInt("c"+a);
                        }
                        if(tblntitle!=null && (tblclass==0 || tblcarr[tblclass-1]==1)){
                %>
                
                <div class="noticeboxnotice border flex jcsb">
                  <div class="nboxleft borde">
                    <div class="notice_title borde"><%=tblntitle%></div>
                    <div class="notice_date borde"><%if(tbldatetime!=null){out.print(tbldatetime);}%></div>
                    <div class="notice_content borde">
                      <%=tblncontent%>
                    </div>
                  </div>
                  <div class="nboxright borde">
                    <div class="subtitleB borde">
                      Comments
                    </div>
                    <div class="icommentbox borde">
                      <%
                        String[] noticeidstr = new String[100];
                        String[] cmtbtnclick = new String[100];
                        String[] cmtusername = new String[100];
                        noticeidstr[count] = request.getParameter("postid"+noticeid[count]);
                        cmtbtnclick[count] = request.getParameter("postidd"+noticeid[count]);
                        String tblf2comment="",tblf2cmtusername="";
                        int tblf2nid=0,tblf2uid=0,f2userid=0;
                        try{
                        Class.forName("com.mysql.jdbc.Driver");  
                        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                        statement=connection.createStatement();
                        sql2 ="select * from comment";
                        String sql4="";
                        sql4="select * from userinfo";
                        resultSet2 = statement.executeQuery(sql4);
                        while(resultSet2.next()){
                          f2userid = resultSet2.getInt("id");
                          cmtusername[f2userid] = resultSet2.getString("name");
                        }
                        resultSet1 = statement.executeQuery(sql2);
                        while(resultSet1.next()){
                          tblf2nid = resultSet1.getInt("nid");
                          tblf2uid = resultSet1.getInt("uid");
                          tblf2comment = resultSet1.getString("content");
                          if(noticeid[count]==tblf2nid){
                      %>
                      <div class="minicommentbox borde">
                        <div class="cmt_owner borde"><%=cmtusername[tblf2uid]%></div>
                        <div class="cmt_content">
                          <%=tblf2comment%>
                        </div>
                      </div>
                        
                      <%
                          }
                        }
                        connection.close();
                        }catch(Exception ex) {
                        System.out.println(ex.toString());
                        }
                      %>
                      
                    </div>
                    <form action="index.jsp" method="POST" class="addcommentbox borde flex jcsb">
                      <div class="borde">
                      <%
                      
                      
                      String inpinpcomment = request.getParameter("inpcomment");
                      boolean inpcommentempty=true,clickpostcmt=false;
                      if(cmtbtnclick[count]!=null){
                        clickpostcmt=true;
                      }
                      if(inpinpcomment!=null){
                        if(!inpinpcomment.equals("")){
                          inpcommentempty=false;
                        }
                      }
                      try{
                        Class.forName("com.mysql.jdbc.Driver");  
                        connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                        statement=connection.createStatement();
                          if(clickpostcmt==true&&inpcommentempty==false){
                            sql2 ="insert into comment(nid,uid,content)values("+noticeidstr[count]+","+tbl_id+",'"+inpinpcomment+"')";
                            statement.executeUpdate(sql2);
                          }else{
                          }
                        connection.close();
                      }catch(Exception ex) {
                        System.out.println(ex.toString());
                      }
                      
                      
                      %>
                      </div>
                      <input type="text" class="inpcomment border" name="inpcomment" placeholder="add comment" value="">
                      <input type="hidden" value="<%=noticeid[count]%>" name="postid<%=noticeid[count]%>">
                      <input type="submit" class="btncomment border" value="Post" name="postidd<%=noticeid[count]%>">
                    </form>
                  </div>
                </div>
                <%
                      }
                    count++;  
                    }              
                    connection.close();
                    }catch(Exception ex) {
                    System.out.println(ex.toString());
                    }
                %>
              </div>
              <%
                }
                else if(pagenum==2){
              %>
              <!-- ============================================== Second Page ============================================== -->
              <div class="profileeditbox borde w100">
                <div class="subtitles">Profile Edit</div>
                <form action="index.jsp?opt=edit" method="POST" class="profileedit border">
                  <%
                    String inpf2email = request.getParameter("f2email");
                    String inpf2name = request.getParameter("f2name");
                    String inpf2pass = request.getParameter("f2password");
                    String inpf2copt = request.getParameter("f2classoption");
                    String inpf2update = request.getParameter("f2update");
                    String tblf2name="",tblf2email="",tblf2email2="",tblf2pass="";
                    String sql3;
                    int tblf2class=-1,f2countuser=0;
                    boolean f2thisuser=false,clickupdate=false,emptyf2inpbox=true;
                    if(inpf2update!=null){
                      if(inpf2update.equals("Update")){
                        clickupdate=true;
                      }
                    }
                    if(inpf2name!=null&&inpf2email!=null&&inpf2pass!=null&&inpf2copt!=null){
                      if(!inpf2name.equals("")&&!inpf2email.equals("")&&!inpf2pass.equals("")&&!inpf2copt.equals("")){
                        emptyf2inpbox=false;
                      }
                    }
                    try{
                    Class.forName("com.mysql.jdbc.Driver");  
                    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                    statement=connection.createStatement();
                    String sql ="select * from userinfo";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()&&f2thisuser==false){
                      tblf2name = resultSet.getString("name");
                      tblf2email = resultSet.getString("email");
                      tblf2pass = resultSet.getString("password");
                      tblf2class = resultSet.getInt("class");
                      if(tblf2email.equals(sessemail)){
                        f2thisuser=true;
                      }
                    }
                    if(f2thisuser==true&&clickupdate==true){
                      resultSet = statement.executeQuery(sql);
                        while(resultSet.next()){
                          tblf2email2 = resultSet.getString("email");
                          if(tblf2email2.equals(inpf2email) && !tblf2email2.equals(sessemail)){
                            f2countuser++;
                          }
                        }
                    }
                    if(clickupdate==true && f2countuser==0&&emptyf2inpbox==false){
                      out.print("update sucess");
                      sql3 = "update userinfo set name='"+inpf2name+"',email='"+inpf2email+"',password='"+inpf2pass+"',class="+inpf2copt+" where email='"+sessemail+"';";
                      statement.executeUpdate(sql3);
                      response.sendRedirect("index.jsp");
                    }
                    connection.close();
                    }catch(Exception ex) {
                    System.out.println(ex.toString());
                    }
                  %>
                  <div class="formtxt1 formtxt0">Name</div>
                  <input type="text" class="inpbox1 inpbox0 border" name="f2name" 
                    value="<%if(clickupdate==false){out.print(tblf2name);}else{out.print(inpf2name);}%>">
                  <div class="formtxt1 formtxt0">Email</div>
                  <input type="text" class="inpbox2 inpbox0 border" name="f2email" 
                    value="<%if(clickupdate==false){out.print(tblf2email);}else{out.print(inpf2email);}%>">
                  <div class="f2msg1 formtxt0 borde">
                    <%
                      if(clickupdate==true && f2countuser==1&&emptyf2inpbox==false){
                          out.print("This email is already in use. ");
                      }
                      else if(clickupdate==true && f2countuser==0&&emptyf2inpbox==false){
                          out.print("update sucess");
                      }
                    %>
                    
                  </div>
                  <div class="formtxt0 formtxt3 borde">Password</div>
                  <input type="text" class="inpbox3 inpbox0 border" name="f2password"
                    value="<%if(clickupdate==false){out.print(tblf2pass);}else{out.print(inpf2pass);}%>">
                  <div class="formoptionbox borde flex">
                    <div class="formtxt4 formtxt0 borde flex aic">
                      Class
                    </div>
                    <select class="classoptionbox border" name="f2classoption">
                      <option class="classoptions" value="">N/A</option>
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
                    <script>
                      var classoptionbox = document.querySelector(".classoptionbox");
                      classoptionbox.value="<%if(clickupdate==false){out.print(tblf2class);}else{out.print(inpf2copt);}%>";
                    </script>
                    <div class="foptmsg border none">
                      Please select a class
                    </div>
                  </div>
                  <div class="formmsgbox borde">
                    <%
                    if(clickupdate==true && f2countuser==0&&emptyf2inpbox==true){
                          out.print("Please fill all the boxes.");
                      }
                    %>
                  </div>
                  <div class="btnbox1 borde">
                    <input type="submit" class="submitbtn" value="Update" name="f2update">
                  </div>
                </form>
              </div>
              <%
                }
                else if(pagenum==3){
              %>
              <!-- ============================================== Third Page ============================================== -->
              <div class="profileeditbox border h100 flex jcc aic">
                <div class="logoutbox border">
                  <div class="logouttext borde">Are you sure you want to log out?</div>
                  <form class="logoutbtnbox flex jcsa">
                    <input type="submit" class="btnyes btnyesno border" value="yes" name="logout">
                    <input type="reset" class="btnno btnyesno border" value="No">
                    
                  </form>
                </div>
              </div>
              <%
                }
                else if(pagenum==4){
              %>
              <!-- ============================================== Fourth Page ============================================== -->
              <div class="addnoticebox borde">
                <div class="subtitles">Add notice</div>
                  <form action="index.jsp?opt=addnotice" method="POST" class="addnotice border">
                    <div class="formtxt1 formtxt0 inptitle">Title</div>
                    <input type="text" class="inpbox1 inpbox0 border" name="ntitle">
                    <div class="formtxt1 formtxt0">Notice</div>
                    <textarea class="inpnotice border" name="ncontent" placeholder="add notice..."></textarea>
                    <div class="formtxt1 formtxt0">Class</div>
                    <div class="checkboxbox borde flex">
                      <div class="ckbxtxt1 ckbxtxt0 borde">1</div>
                      <input type="checkbox" class="c1 c0" name="c1" value="c1" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">2</div>
                      <input type="checkbox" class="c2 c0" name="c2" value="c2" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">3</div>
                      <input type="checkbox" class="c3 c0" name="c3" value="c3" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">4</div>
                      <input type="checkbox" class="c4 c0" name="c4" value="c4" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">5</div>
                      <input type="checkbox" class="c5 c0" name="c5" value="c5" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">6</div>
                      <input type="checkbox" class="c6 c0" name="c6" value="c6" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">7</div>
                      <input type="checkbox" class="c7 c0" name="c7" value="c7" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">8</div>
                      <input type="checkbox" class="c8 c0" name="c8" value="c8" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">9</div>
                      <input type="checkbox" class="c9 c0" name="c9" value="c9" checked>
                      <div class="ckbxtxt1 ckbxtxt0 borde">10</div>
                      <input type="checkbox" class="c10 c0" name="c10" value="c10" checked>
                    </div>
                    <input type="hidden" class="inputdate" name="inputdate" value="">
                    <div class="btnbox4 borde">
                      <input type="submit" class="submitbtn" value="Upload" name="p4submitbtn">
                      <input type="reset" class="resetbtn" value="Reset">
                    </div>
                    <%
                    String inpntitle = request.getParameter("ntitle");
                    String inpncontent = request.getParameter("ncontent");
                    String inpinputdate = request.getParameter("inputdate");
                    String inpc1 = request.getParameter("c1");
                    String inpc2 = request.getParameter("c2");
                    String inpc3 = request.getParameter("c3");
                    String inpc4 = request.getParameter("c4");
                    String inpc5 = request.getParameter("c5");
                    String inpc6 = request.getParameter("c6");
                    String inpc7 = request.getParameter("c7");
                    String inpc8 = request.getParameter("c8");
                    String inpc9 = request.getParameter("c9");
                    String inpc10 = request.getParameter("c10");
                    String p4subbnt = request.getParameter("p4submitbtn");
                    String sql1="";
                    boolean empinpnotice=true;
                    boolean cc1=false,cc2=false,cc3=false,cc4=false,cc5=false,cc6=false,cc7=false,cc8=false,cc9=false,cc10=false;
                    if(inpc1!=null){cc1=true;}else{cc1=false;}
                    if(inpc2!=null){cc2=true;}else{cc2=false;}
                    if(inpc3!=null){cc3=true;}else{cc3=false;}
                    if(inpc4!=null){cc4=true;}else{cc4=false;}
                    if(inpc5!=null){cc5=true;}else{cc5=false;}
                    if(inpc6!=null){cc6=true;}else{cc6=false;}
                    if(inpc7!=null){cc7=true;}else{cc7=false;}
                    if(inpc8!=null){cc8=true;}else{cc8=false;}
                    if(inpc9!=null){cc9=true;}else{cc9=false;}
                    if(inpc10!=null){cc10=true;}else{cc10=false;}
                        
                    if(inpntitle!=null&&inpncontent!=null){
                      if(!inpntitle.equals("")&&!inpncontent.equals("")){
                          empinpnotice=false;
                      }
                    }
                    try{
                    Class.forName("com.mysql.jdbc.Driver");  
                    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                    statement=connection.createStatement();
                    if(p4subbnt!=null && empinpnotice==false){
//                     sql1 = "insert into notice(title,content,c1)values('"+inpntitle+"','"+inpncontent+"',"
//                                +cc1+","+cc2+");";
                        sql1 = "insert into notice(title,content,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,datetime)values('"+inpntitle+"','"+inpncontent+"',"
                                +cc1+","+cc2+","+cc3+","+cc4+","+cc5+","+cc6+","+cc7+","+cc8+","+cc9+","+cc10+",'"+inpinputdate+"');";
                        statement.executeUpdate(sql1);
                        out.print("<script>alert('Notice sucessfully created.');</script>");
                    }
                    else if(p4subbnt!=null && empinpnotice==true){
                        out.print("Please fill all the input boxes.");
                        
                    }
                    connection.close();
                    }catch(Exception ex) {
                    System.out.println(ex.toString());
                    }
                    %>
                  </form>
                </div>
              <%
                }
              %>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      
      var btnno = document.querySelector(".btnno");
      btnno.addEventListener('click',()=>{
        window.open("index.jsp?opt=notice", "_self");
      });
      var inputdate = document.querySelector(".inputdate");
      setInterval(()=>{
        var d=new Date(),hr=d.getHours(),min=d.getMinutes(),ap="AM",dt=d.getDate(),mt=d.getMonth(),mth,ddate;
        switch(mt){
        case 0:mth="January";break;
        case 1:mth="February";break;
        case 2:mth="March";break;
        case 3:mth="April";break;
        case 4:mth="May";break;
        case 5:mth="June";break;
        case 6:mth="July";break;
        case 7:mth="August";break;
        case 8:mth="September";break;
        case 9:mth="October";break;
        case 10:mth="November";break;
        case 11:mth="December";break;
      }
      if(hr>12){hr=hr-12;hr=hr.toString();hr="0"+hr;ap="PM";}
      if(hr<10){hr=hr.toString();hr="0"+hr;}
      if(min<10){min=min.toString();min="0"+min;}
      ddate=hr+":"+min+" "+ap+" "+dt+" "+mth;
      inputdate.value=ddate;
      console.log(ddate);
      },100);
      
    </script>
  </body>
</html>
<%
        }
%>