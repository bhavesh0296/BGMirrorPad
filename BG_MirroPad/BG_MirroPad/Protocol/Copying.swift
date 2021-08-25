//
//  Copying.swift
//  BG_MirroPad
//
//  Created by bhavesh on 25/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

public protocol Copying {
    init(_ prototype: Self)
}

extension Copying{
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}

extension Array where Element: Copying {
    public func deepCopy() -> [Element] {
        return self.map {$0.copy()}
    }

}
