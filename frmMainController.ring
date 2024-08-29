# Form/Window Controller - Source Code File

load "frmMainView.ring"
load "mylib_ashraf.ring"
load "mysql_ashraf.ring"
load "frmProgramController.ring"




import System.GUI

if IsMainSourceFile() {
	new App {
		StyleFusion()
		openWindow(:frmMainController)
		exec()
	}
}

class frmMainController from windowsControllerParent

	oView = new frmMainView
	t = new formtools(oview.win)
	t.center()
 	t.icon("ring.png")


	func Creat_DataBAse()
		Mysql_Connect_now()
		mysql_run("
			Create Database if not exists myringprogram
			default Character set utf8 default collate utf8_general_ci
		")		
		mysql_close_now()
		t.msgbox("Done......")


	func Creat_Tables()
		db_name = "myringprogram" 
		mysql_connect_now()
		mysql_run("
			CREATE TABLE IF NOT EXISTS myUsers 
			(username varchar(50) primary key,
			 password varchar(50)
			)
		")
		r = mysql_get("select count(*) from myUsers")//عمل متغير للتأكد من خلو الجدول من البيانات
		if r[2][1] = 0 // لو الراجع بصفر يبقى مفيش بيانات 
			mysql_run("insert into myusers values('admin','admin')")// لو مفيش بيانات يضيف اول صف وهو الادمن
		ok
		mysql_run("
			CREATE TABLE IF NOT EXISTS department 
			(department_Id int primary key,
			 department_name varchar(100),
			 department_location varchar(100)
			)
		")
		mysql_run("
			CREATE TABLE IF NOT EXISTS employee 
			(employee_Id int primary key,
			 employee_name varchar(100),
			 adress varchar(150),
			 salary int,
			 department_id int,
			 foreign key(department_id) references department(department_id)
			)
		")

		mysql_close_now()
		t.msgbox("Done......")


	func OpentProgram()
		strUser = t.imputBox("Enter Your UserName")
		strPass = t.imputboxPass("Enter your password")
	
		db_name = "myringprogram" 
		mysql_connect_now()
		//leson 265
		r = mysql_get("select count(*) from myusers where username = '" + strUser + "' and password = '" + strPass + "' ")
		if r[2][1] = 1 
			open_window(:frmProgramController)// فتح الشاشة
			t.win().close()
		else
			t.msgbox("Username or password incorrect")
		ok


		//see = mysql_get("select * from myusers") //where username = 'strUser' and password = 'strPass' ")
		//see = mysql_get("select count(*) from myUsers")
		mysql_close_now()
		t.win().setwindowtitle("My Main Form")

		//open_window(:frmProgramController)// فتح الشاشة
		//t.win().close()
		
