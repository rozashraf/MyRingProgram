class formTools{
	func init(form){
		Load "stdlibcore.ring"
		Load "guilib.ring"
		import System.GUI	
		myform = form
		}
		
		func icon(path) setWinicon(myform , path)

		func win() return myform


		func changeForm(newForm){myform = newform} // استبدال الشاشة
//=====================عروض الشاشة==========================
		func winNormal(){myform.shownormal()} // عرض الشاشة الطبيعي
		func winMix(){myform.showmaximized()} // عرض الشاشة بحجم كبير
		func winMin(){myform.showminimized()} // عرض الشاشة بحجم صغير
		func winfull(){myform.showfullscreen()} // عرض الشاشة كامل حجمها
		func center(){ // عرض الشاشة بالمنتصف
			screenW = mydesktop.width()
			screenH = mydesktop.height()
			formW = myform.width()
			formH = myform.height()
			x = (screenw - formw)/2
			y = (screenH - formh)/2
			myform.move(x , y )
		}

		func MsgBox(text){
			frm = myform
			msg = new messagebox(frm) {
				setwindowtitle(frm.windowtitle())
				settext(text)
				show()
			}
		}
		
		func imputBox(Text){
			frm = myform 
			inbox = new inputdialog(frm) {
				setwindowtitle(frm.windowtitle())
				setlabeltext(text)				
				exec()
			}
			return inbox.textvalue()
		}
		
		func imputBoxPass(Text){
			frm = myform 
			inbox = new inputdialog(frm) {
				setwindowtitle(frm.windowtitle())
				setlabeltext(text)				
				settextechomode(2)
				exec()
			}
			return inbox.textvalue()
		}
		func ShowNewForm(){
			frm = new window() {
				setwindowtitle("New Form")
				show()
			}
			return frm
		}

		func GetNewForm(){
			frm = new window() {
				setwindowtitle("New Form")
			}
			return frm
		}

		private

		myForm
		myDesktop = new qdesktopwidget() // عمل متغير لاظهار عرض وطول الشاشة
}

class DataTable{
	Columns = []// متغير أعمدة 
	Rows = []// متغير صفوف
	TableName = " "// متغير باسم الجدول
	ReadOnly = True
	SelectAllRow = True 
	
	func init(){ TableName = "MyTable"} // وظيفة تشغيل اتوماتيك
	func setTableName(Name) {this.TableName=Name} // وضع اسم للجدول
	func SetReadONly(state) {this.ReadOnly=state} // جعل الجدول للقراءة فقط
	func SetSelectAllRow(state){this.SelectAllRow}// اختيار كل الصفوف
	func AddColumn(ColumnName){Add(this.Columns, ColumnName)} // إضافة عمود
	func AddRows(RowList){Add(this.Rows, RowList)}// إضافة صف
	func ColumnsCount(){return len(this.columns)}// عدد الأعمدة
	func RowsCount(){return len(this.Rows)}// عدد الصفوف

	func LoadInto(TableWidgetTarget)
		if len(this.Columns)<1
			Raise("This table dose not contain any columns")
		ok
		for x=1 to len(this.Rows)
			if len(this.Rows[x]) != len(this.Columns)
				Raise("One Or more row has diffrent values with number of columns")
			ok 
		next
		tbl = TableWidgetTarget
		tbl.setcolumncount(len(this.Columns))
		tbl.SetRowCount(len(this.Rows))
}
