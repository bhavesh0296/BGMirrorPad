//
//  AcceptInputView.swift
//  BG_MirroPad
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

public class AcceptInputState: DrawViewState {

    public override func animate() {
        let animateState = transitionToState(matching: AnimateState.identifier)
        animateState.animate()
    }

    public override func clear() {
        let clearState = transitionToState(matching: ClearState.identifier)
        clearState.clear()
    }

    public override func copyLines(from source: DrawView) {
        let copyState = transitionToState(matching: CopyState.identifier)
        copyState.copyLines(from: source)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: drawView) else {
            return
        }
        let line = LineShape(color: drawView.lineColor,
                             width: drawView.lineWidth,
                             startPoint: point)

        addLine(line)
//        drawView.lines.append(line)
//        drawView.layer.addSublayer(line)

        drawView.multicastDelegate.invokeDelegates { delegate in
            delegate.drawView(drawView, didAddLine: line)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: drawView),
            drawView.bounds.contains(point),
            let currentLine = drawView.lines.last else {
                return
        }

        addPoint(point)
//        currentLine.addPoint(point)

        drawView.multicastDelegate.invokeDelegates { delegate in
            delegate.drawView(drawView, didAddPoint: point)
        }
    }

    private func addLine(_ line: LineShape){
        drawView.lines.append(line)
        drawView.layer.addSublayer(line)
    }

    private func addPoint(_ point: CGPoint){
        drawView.lines.last?.addPoint(point)
    }
}

extension AcceptInputState {

    public override func drawView(_ source: DrawView, didAddLine line: LineShape) {
        let newLine = line.copy() as LineShape
        addLine(newLine)
    }

    public override func drawView(_ source: DrawView, didAddPoint point: CGPoint) {
        addPoint(point)
    }
}
