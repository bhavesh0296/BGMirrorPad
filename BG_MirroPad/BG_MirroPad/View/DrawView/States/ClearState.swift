//
//  ClearState.swift
//  BG_MirroPad
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

public class ClearState: DrawViewState {

    public override func clear() {
        drawView.lines = []
        drawView.layer.sublayers?.removeAll()
        transitionToState(matching: AcceptInputState.identifier)
    }
}
