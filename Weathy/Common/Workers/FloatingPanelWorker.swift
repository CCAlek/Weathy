//
//  FloatingPanelWorker.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import FloatingPanel
import UIKit

class FloatingPanelWorker {
    private enum ViewMetrics {
        static let radius: CGFloat = 20
        static let insets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        static let grabberColor: UIColor! = R.color.gray()
        static let grabberWidth: CGFloat = 42
        static let grabberHeight: CGFloat = 4
        static let grabberMargin: CGFloat = 8
    }
    
    func present(_ view: UIView, with viewController: UIViewController, panel: FloatingPanelController) {
        let floatingViewController = UIViewController()
        floatingViewController.view = view
        
        panel.set(contentViewController: floatingViewController)
        if let trackingScrollView = view as? UIScrollView {
            panel.track(scrollView: trackingScrollView)
        }
        
        panel.isRemovalInteractionEnabled = true
        
        panel.surfaceView.backgroundColor = R.color.clearWhite()
        
        panel.surfaceView.cornerRadius = ViewMetrics.radius
        panel.surfaceView.contentInsets = ViewMetrics.insets
        
        panel.surfaceView.grabberHandle.backgroundColor = ViewMetrics.grabberColor
        panel.surfaceView.grabberHandleWidth = ViewMetrics.grabberWidth
        panel.surfaceView.grabberHandleHeight = ViewMetrics.grabberHeight
        panel.surfaceView.grabberTopPadding = ViewMetrics.grabberMargin
        
        viewController.present(panel, animated: true)
    }
}
