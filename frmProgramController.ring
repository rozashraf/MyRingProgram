# Form/Window Controller - Source Code File

load "frmProgramView.ring"
load "mylib_ashraf.ring"
load "frmDepartmentController.ring"
load "frmEmployeeController.ring"

import System.GUI

if IsMainSourceFile() {
	new App {
		StyleFusion()
		openWindow(:frmProgramController)
		exec()
	}
}

class frmProgramController from windowsControllerParent

	oView = new frmProgramView
	t = new formtools(oview.win)
	t.center()
	t.icon("ring.png")


	func OpenDept()
		open_window(:frmDepartmentController)


	func open_Employee()
		open_window(:frmEmployeeController)
