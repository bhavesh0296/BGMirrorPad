//
//  ViewController.swift
//  BG_MirroPad
//
//  Created by bhavesh on 25/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
     @IBOutlet public var drawViewContainer: UIView!
     @IBOutlet public var inputDrawView: DrawView!
     @IBOutlet public var mirrorDrawViews: [DrawView]!

     // MARK: - Actions
     @IBAction public func animatePressed(_ sender: Any) {
       inputDrawView.animate()
     }

     @IBAction public func clearPressed(_ sender: Any) {
       inputDrawView.clear()
       mirrorDrawViews.forEach { $0.clear() }
     }

     @IBAction public func sharePressed(_ sender: Any) {

     }
}
