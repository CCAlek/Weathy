//
//  FixedFloatingPanelDelegate.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import FloatingPanel

class FixedFloatingPanelDelegate: NSObject, FloatingPanelControllerDelegate {
    
    var viewMetrics: FixedFloatingPanelViewMetrics
    var type: FloatingPanelType
    
    init(viewMetrics: FixedFloatingPanelViewMetrics = FixedFloatingPanelViewMetrics(),
         type: FloatingPanelType = .fixed) {
        self.viewMetrics = viewMetrics
        self.type = type
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return FixedFloatingPanelLayout(viewMetrics: viewMetrics, type: type)
    }
}

enum FloatingPanelType {
    case tip
    case fixed
}

class FixedFloatingPanelLayout: FloatingPanelLayout {
    
    var viewMetrics: FixedFloatingPanelViewMetrics
    var type: FloatingPanelType
    
    init(viewMetrics: FixedFloatingPanelViewMetrics = FixedFloatingPanelViewMetrics(),
         type: FloatingPanelType = .fixed) {
        self.viewMetrics = viewMetrics
        self.type = type
    }
    
    var initialPosition: FloatingPanelPosition {
        if isFullPositionOnly() {
            return .full
        } else {
            return .tip
        }
    }
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        switch type {
        case .tip:
            return [.tip]
        case .fixed:
            if isFullPositionOnly() {
                return [.full]
            } else {
                return [.full, .tip]
            }
        }
    }
    
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.2
    }

    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full:
            return 44 // A top inset from safe area
        case .tip:
            return getTipInset() // A bottom inset from the safe area
        default:
            return nil // Or `case .hidden: return nil`
        }
    }
    
    private func getTipInset() -> CGFloat {
        var contentHeight: CGFloat
        if type == .tip {
            contentHeight = viewMetrics.contentHeight
        } else {
            switch viewMetrics.numberOfRows {
            case 1:
                contentHeight = viewMetrics.contentHeight + 2 * viewMetrics.estimatedRowHeight
            case 2:
                contentHeight = viewMetrics.contentHeight + viewMetrics.estimatedRowHeight
            default:
                contentHeight = viewMetrics.contentHeight
            }
        }
        
        let tipInset = contentHeight + viewMetrics.topInset + viewMetrics.bottomMargin
        return tipInset
    }
    
    private func isFullPositionOnly() -> Bool {
        let maxTipInset = viewMetrics.viewHeight - viewMetrics.safeAreaTopInset
        return getTipInset() > maxTipInset
    }
}
