//
//  AnimateState.swift
//  BG_MirroPad
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

public class AnimateState: DrawViewState {

    public override func animate() {
        guard let sublayes = drawView.layer.sublayers,
            sublayes.count > 0 else {
                transitionToState(matching: AcceptInputState.identifier)
                return
        }

        sublayes.forEach { $0.removeAllAnimations() }

        UIView.animate(withDuration: 0.3) {
            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.transitionToState(matching: AcceptInputState.identifier)
            }
            self.setSublayersStrokeEnd(to: 0.0)
            self.animateStrokeEnds(of: sublayes, at: 0)
            CATransaction.commit()
        }
    }

    private func setSublayersStrokeEnd(to value: CGFloat) {
        drawView.layer.sublayers?.forEach({ (subLayer) in
            guard let shapeLayer = subLayer as? CAShapeLayer else { return }
            shapeLayer.strokeEnd = 0.0
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = value
            animation.toValue = value
            animation.fillMode = .forwards
            subLayer.add(animation, forKey: nil)
        })
    }

    private func animateStrokeEnds(of layers: [CALayer], at index: Int) {
        guard index < layers.count else { return }
        let currentLayer = layers[index]
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            currentLayer.removeAllAnimations()
            self?.animateStrokeEnds(of: layers, at: index + 1)
        }

        if let shapeLayer = currentLayer as? CAShapeLayer {
            shapeLayer.strokeEnd = 1.0
            let animation = CABasicAnimation(keyPath: "StrokeEnd")
            animation.duration = 1.0
            animation.fillMode = .forwards
            animation.fromValue = 0.0
            animation.toValue = 1.0
            shapeLayer.add(animation, forKey: nil)
        }
        CATransaction.commit()
    }
}
