//
//  CGDHelpers.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

/// Shortened version of CGD, that executes in main thread
func onMainThread(_ block: @escaping EmptyClosure) {
    DispatchQueue.main.async(execute: block)
}

/// Shortened version of CGD, that executes in background thread
func onBackgroundThread(_ block: @escaping EmptyClosure) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: block)
}

/// User initiated means the user directly requested this operation, and is likely waiting, but the UI itself is not desperate for a result.
func onUserInitiatedThread(_ block: @escaping EmptyClosure) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async(execute: block)
}

func onMainThreadWithDelay(_ block: @escaping EmptyClosure) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: block)
}
