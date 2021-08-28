//
//  MulticastDelegate.swift
//  BG_MirroPad
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

public class MulticastDelegate<ProtocolType> {

    private class DelegateWrapper {
        weak var delegate: AnyObject?

        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }

    private var delegateWrappers: [DelegateWrapper]

    public var delegates: [ProtocolType] {
        delegateWrappers = delegateWrappers.filter { $0.delegate != nil }
        return delegateWrappers.map { $0.delegate } as! [ProtocolType]
    }

    public init(_ delegates: [ProtocolType] = []){
        delegateWrappers = delegates.map { DelegateWrapper($0 as AnyObject)}
    }

    public func addDelegate(_ delegate: ProtocolType) {
        delegateWrappers.append(DelegateWrapper(delegate as AnyObject))
    }

    public func removeDelegate(_ delegate: ProtocolType){
        guard let index = delegateWrappers.firstIndex(where: { $0.delegate === (delegate as AnyObject)}) else {
            return
        }
        delegateWrappers.remove(at: index)
    }

    public func invokeDelegates(_ closure: (ProtocolType) -> Void) {
        delegates.forEach {closure($0)}
    }
}

