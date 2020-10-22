//
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

class MainView: UIView {

    private enum ViewMetrics {
        static let backgroundColor = R.color.clearWhite()
    }

    private lazy var customView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
    }
}
