//
//  UIButton+Extension.swift
//  AppComponents
//
//  Created by TLSP-000092 on 21/12/21.
//

import UIKit

public extension UIButton {
	
	public func setBorder(_ color: UIColor, width: CGFloat) {
		layer.borderColor = color.cgColor
		layer.borderWidth = width
	}
	
}
