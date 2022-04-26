-------- inside this dash is comment --------
STEP 1:
open xampp then start Apache and MySql

STEP 2:
open command prompt then type following command

STEP 3:

cd/
-------- hit enter -------- 

cd xampp/mysql/bin
-------- hit enter -------- 

mysql -u root -p
-------- hit enter -------- 
-------- again hit enter -------- 

STEP 4:

-------- copy past below command and hit enter -------- 

create database noticee;use noticee;
create table userinfo(id int(4) primary key auto_increment,name varchar(50),email varchar(50),password varchar(50),class int(2),utype varchar(10));
create table notice(nid int(4) primary key auto_increment,title varchar(50),content text,c1 tinyint(1),c2 tinyint(1),c3 tinyint(1),c4 tinyint(1),c5 tinyint(1),c6 tinyint(1),c7 tinyint(1),c8 tinyint(1),c9 tinyint(1),c10 tinyint(1),datetime varchar(20));
create table comment(cid int(4) primary key auto_increment,nid int(4),uid int(4),content text);
insert into userinfo(name,email,password,class,utype)values('Mallika Shrestha','monikashrestha00@gmail','@dmin',0,'admin');
show tables;

STEP 5:
downlaod this project and open from netbeans

STEP 6:
run this project(hit green play button), netbeans will take some time to open server
after a while new popup will open in netbeans click Yes

STEP 7:

-------- copy below link and paste in browser --------

http://localhost:8080/noticeboard/index.jsp

STEP 8:

NOTE:
an admin user is alread created
username: monikashrestha00@gmail
password: @dmin

You can try creating new account, login logout, post notice, comment in notice with diffrent user id,
edit profile and use forget password
