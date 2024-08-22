# Form/Window Controller - Source Code File

load "frmDepartmentView.ring"
load "mylib_ashraf.ring"
load "mysql_ashraf.ring"


import System.GUI

if IsMainSourceFile() {
	new App {
		StyleFusion()
		openWindow(:frmDepartmentController)
		exec()
	}
}

class frmDepartmentController from windowsControllerParent

	oView = new frmDepartmentView
	
	t = new formtools(oview.win)
	t.center()
 	t.icon("ring.png")
	oview.txtDeptNo.setreadonly(1)// جعل حقل الرقم للقراءة فقط

	db_name = "myringprogram"
	mysql_connect_now()// فتح الاتصالا

	mysql_fill_table(oview.TableWidget1, "select * from department")//وضع بيانات في جدول البيانات



	oview.ofilter = new qallevents(oview.win) // الثلاث اسطر معناهم انشاء حدث عند انغلاق الشاشة يشغل يقفل قاعدة البيانات
	oview.ofilter.setcloseevent( method(:form_close))
	oview.win.installeventfilter(oview.ofilter)
	
	clear_data() // تشغيل وظيفة مسح الخانات في بداية تشغيل الفورم

	oview.tablewidget1.setitemselectionchangedevent(method(:select_Data))//وضع الوظيفة داخل حدث التغيير

	func select_Data()
		curRow = oview.TableWidget1.currentrow()//انشاء متغيل ووضع بداخله الصف المختار
		deptno = oview.tablewidget1.item(curRow , 1).text()// انشاء متغير ووضع بداخله رقم الصف والعمود المختار
		deptname = oview.tablewidget1.item(curRow , 2).text()// انشاء متغير ووضع بداخله رقم الصف والعمود المختار
		deptlocation = oview.tablewidget1.item(curRow , 3).text()// انشاء متغير ووضع بداخله رقم الصف والعمود المختار
		oview.txtdeptno.settext( deptno)// وضع المتغير داخل مربع النص الرقم
		oview.txtDeptName.settext( deptname)// وضع المتغير داخل مربع النص الرقم
		oview.txtDeptLocation.settext( deptlocation)// وضع المتغير داخل مربع النص الرقم
		oview.btnAdd.setenabled(0) // قفل مفتاح الاضافة
		oview.btnDelete.setenabled(1) // فتح مفتاح المسح
		oview.btnEdit.setenabled(1) // فتح مفتاح التحرير

	func clear_data() // وظيفة مسح الخانات
		oview.txtdeptname.settext("") // وضع نص فارغ في حقل الاسم
		oview.txtDeptLocation.settext("") // وضع نص فارغ في حقل الموقع
		autoNum = mysql_auto_number("department", "department_Id") // متغير بداخله اخر رقم ترقيم تلقائي
		oview.txtdeptno.settext( autonum)// وضع الرقم داخلي حقل الرقم
		oview.btnDelete.setenabled(0) // تجميع مفتاح المسح
		oview.btnEdit.setenabled(0) // تجميد مفتاح التحرير
		oview.btnAdd.setenabled(1) // فتح مفتاح اضافة
		oview.txtdeptname.setfocus(1) // وضع المؤشر في حقل الاسم

	func form_close()
		mysql_close_now() // قفل الاتصال



	func Add_Dept()// إضافة موظف جديد
		if trim(oview.txtdeptno.text()) = "" // التأكيد ان مربع النص غير فارغ
			t.msgbox("Department Number is empty!")
			bye
		ok
		if trim(oview.txtdeptname.text()) = "" 
			t.msgbox("Department name is empty!")
			bye
		ok
		if trim(oview.txtDeptLocation.text()) = "" 
			t.msgbox("Department Location is empty!")
			bye
		ok

	func Edit_Dept()// إضافة موظف جديد
		if trim(oview.txtdeptno.text()) = "" // التأكيد ان مربع النص غير فارغ
			t.msgbox("Department Number is empty!")
			bye
		ok
		if trim(oview.txtdeptname.text()) = "" 
			t.msgbox("Department name is empty!")
			bye
		ok
		if trim(oview.txtDeptLocation.text()) = "" 
			t.msgbox("Department Location is empty!")
			bye
		ok
