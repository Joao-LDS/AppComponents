//
//  ViewController.swift
//  SandBox
//
//  Created by TLSP-000092 on 21/12/21.
//

import UIKit
import AppComponents

class ViewController: UIViewController {

	@IBOutlet weak var button: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		button.setBorder(.blue, width: 1)
		button.setCorner(6)
	}

}

