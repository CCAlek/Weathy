//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

class MainBuilder: ModuleBuilder {

    var initialState: Main.ViewControllerState?

    func set(initialState: Main.ViewControllerState) -> MainBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter)
        let controller = MainViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
