//
//  AnchorKey.swift
//  ProgressEffect
//
//  Created by Bao Hoang on 15/10/2023.
//

import SwiftUI

/**
 This anchor preference key is used to store the source and destination frame values, and with those values, we can establish a smooth progress-based transition from the source view to the destination view.
 */
struct AnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>],
                       nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) {
            $1
        }
    }
}
