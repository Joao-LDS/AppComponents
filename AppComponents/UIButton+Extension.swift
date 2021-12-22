//
//  UIButton+Extension.swift
//  AppComponents
//
//  Created by TLSP-000092 on 21/12/21.
//

import UIKit

public extension UIButton {
	
	func setBorder(_ color: UIColor, width: CGFloat) {
		layer.borderColor = color.cgColor
		layer.borderWidth = width
	}
	
	func setCorner(_ value: CGFloat) {
		layer.cornerRadius = value
	}
	
	func setColor(_ color: UIColor) {
		backgroundColor = color
	}
	
	func addPrintLabel() {
		addTarget(self, action: #selector(printTitleLabel), for: .touchUpInside)
	}
	
	@objc private func printTitleLabel(_ sender: UIButton) {
		print(sender.titleLabel?.text ?? "")
	}
}
