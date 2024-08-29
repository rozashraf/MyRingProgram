# Form/Window Controller - Source Code File

load "frmEmployeeView.ring"
load "mylib_ashraf.ring"
load "mysql_ashraf.ring"

import System.GUI

if IsMainSourceFile() {
	new App {
		StyleFusion()
		openWindow(:frmEmployeeController)
		exec()
	}
}

class frmEmployeeController from windowsControllerParent

	oView = new frmEmployeeView
	t = new formtools(oview.win)
	t.center()
 	t.icon("ring.png")
	oview.CheckBoxAutoSearch.setchecked(1)
	db_name = "myringprogram"
	mysql_connect_now()
	oview.ofilter = new qallevents(oview.win) // الثلاث اسطر معناهم انشاء حدث عند انغلاق الشاشة يشغل يقفل قاعدة البيانات
	oview.ofilter.setcloseevent( method(:form_close))// عند غلق البرنامج ينادي على الوظيفة غلق الشاشة
	oview.win.installeventfilter(oview.ofilter)

	//fill_data() //ملئ جدول البيانات
	btnClear_click() // تشغيل وظيفة مسح الخانات في بداية تشغيل الفورم	


//	func fill_data() انا واقف هنا ومش عارف اجيبها
	mysql_fill_combobox("select * from department", oview.ComboboxDepartmentID, "department" , "department.name")//وضع بيانات في جدول البيانات

	func btnClear_click() // وظيفة مسح الخانات
		oview.LineEditName.settext("") // وضع نص فارغ في حقل الاسم
		oview.LineEditAdress.settext("") // وضع نص فارغ في حقل الموقع
		autoNum = mysql_auto_number("employee", "employee_Id") // متغير بداخله اخر رقم ترقيم تلقائي
		oview.LineEditSalary.settext( autonum)// وضع الرقم داخلي حقل الرقم
		oview.ButtonDelete.setenabled(0) // تجميع مفتاح المسح
		oview.ButtonEdit.setenabled(0) // تجميد مفتاح التحرير
		oview.ButtonAdd.setenabled(1) // فتح مفتاح اضافة
		oview.LineEditName.setfocus(1) // وضع المؤشر في حقل الاسم


	func form_close() 
		mysql_close_now() // قفل الاتصال
	


	
