import Foundation

protocol SetupView {
	func addSubviews()
	func addContraints()
	func addConfiguration()
	func setupUI()
}

extension SetupView {
	func setupUI() {
		addSubviews()
		addContraints()
		addConfiguration()
	}
}
