//
//  Array.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
