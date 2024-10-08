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
	oview.CheckBoxAutoSearch.setchecked(1)

	db_name = "myringprogram"
	mysql_connect_now()// فتح الاتصالا
	fill_data() //ملئ جدول البيانات
	clear_data() // تشغيل وظيفة مسح الخانات في بداية تشغيل الفورم	


	oview.ofilter = new qallevents(oview.win) // الثلاث اسطر معناهم انشاء حدث عند انغلاق الشاشة يشغل يقفل قاعدة البيانات
	oview.ofilter.setcloseevent( method(:form_close))
	oview.win.installeventfilter(oview.ofilter)
	


	oview.tablewidget1.setitemselectionchangedevent(method(:select_Data))//وضع الوظيفة داخل حدث التغيير
	

	func fill_data()
		mysql_fill_data(oview.TableWidget1, "select * from department")//وضع بيانات في جدول البيانات

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

	// lessen 271
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

		debtno = oview.txtdeptno.text()
		debtname = oview.txtdeptname.text()
		debtlocation = oview.txtdeptlocation.text()
		strInsert = "insert into department values(" + debtno + " ,'" + debtname + "','" + debtlocation + "')"
		mysql_run( strInsert ) // اضافة البيانات داخل قاعدة البيانات
		fill_data()// ملئ جدول البيانات
		clear_data() // مسح البيانات من مربعات النصوص

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

		debtno = oview.txtdeptno.text()
		debtname = oview.txtdeptname.text()
		debtlocation = oview.txtdeptlocation.text()
		strInsert = "update department set department_name = '"+debtname+"', department_location = '"+debtlocation+"' where department_id = " + debtno
		mysql_run( strInsert ) // اضافة البيانات داخل قاعدة البيانات
		fill_data()// ملئ جدول البيانات
		clear_data() // مسح البيانات من مربعات النصوص
		
		
	func Del_Dept()
		if t.MsgBoxYesNo("Do you want to delet?")
			strDel = "delete from department where department_id = " + oview.txtdeptno.text()
			mysql_run(strdel)
			fill_data()
			clear_data()
		ok
		


	func Find_Dept()
		DeptNo=  t.imputBoxInt("Enter Department Number: ")		
		strSel = "Select * from department where department_id = " + deptno 
		if len(mysql_get(strSel))=1
			t.msgbox("This Number not found!")
		else 
			mysql_fill_data(oview.TableWidget1, strsel)
		ok


	func search_dept()
		strSearch = oview.txtSearch.text()
		strSelect = "
			select * from department 
			where department_name 		like '%" + strSearch + "%' or 
						department_location like '%" + strSearch + "%'
		"
		if len(mysql_get(strSelect))=1 
			t.msgbox("لم يتم العثور على نتيجة لبحثك")
			bye	 
		ok
		mysql_fill_data(oview.TableWidget1, strSelect)
			
		if oview.txtsearch.text() = "" 
			//t.msgbox("من فضل ادخل كلمة للبحث عنها")
			fill_data()
		ok

	func search_dept2()
		if oview.CheckBoxAutoSearch.ischecked()
			search_dept()
		ok

	func show_result_count()
		oview.LabelCount.settext("Result : " + string(oview.tablewidget1.rowcount() ) )

	func form_close()
		mysql_close_now() // قفل الاتصال

	
