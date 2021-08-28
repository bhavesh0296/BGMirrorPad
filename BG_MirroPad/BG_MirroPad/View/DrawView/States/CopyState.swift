//
//  CopyState.swift
//  BG_MirroPad
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

public class CopyState: DrawViewState {

    public override func copyLines(from source: DrawView) {
        drawView.layer.sublayers?.removeAll()
        drawView.lines = source.lines.deepCopy()
        drawView.lines.forEach { drawView.layer.addSublayer($0) }
        transitionToState(matching: AcceptInputState.identifier)
    }
}
