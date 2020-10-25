//
//  FixedFloatingPanelViewMetrics.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

struct FixedFloatingPanelViewMetrics {
    let topInset: CGFloat
    let bottomMargin: CGFloat
    let contentHeight: CGFloat
    let estimatedRowHeight: CGFloat
    let numberOfRows: Int
    let viewHeight: CGFloat
    let safeAreaTopInset: CGFloat
    
    init(topInset: CGFloat = 16,
         bottomMargin: CGFloat = 48,
         contentHeight: CGFloat = 0,
         estimatedRowHeight: CGFloat = 0,
         numberOfRows: Int = 0,
         viewHeight: CGFloat = 0,
         safeAreaTopInset: CGFloat = 0) {
        self.topInset = topInset
        self.bottomMargin = bottomMargin
        self.contentHeight = contentHeight
        self.estimatedRowHeight = estimatedRowHeight
        self.numberOfRows = numberOfRows
        self.viewHeight = viewHeight
        self.safeAreaTopInset = safeAreaTopInset
    }
}
