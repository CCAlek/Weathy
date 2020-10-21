//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainPresentationLogic {

    // Do something ...
    func presentSomething(response: Main.Something.Response)
}

/// Отвечает за отображение данных модуля Main
class MainPresenter: MainPresentationLogic {

    weak var viewController: MainDisplayLogic?

    // MARK: Do something ...
    func presentSomething(response: Main.Something.Response) {
        var viewModel: Main.Something.ViewModel
        
        switch response.result {
        case let .success(result):
            if result.isEmpty {
                viewModel = Main.Something.ViewModel(state: .emptyResult)
            } else {
                viewModel = Main.Something.ViewModel(state: .result(result))
            }
        case let .failure(error):
            viewModel = Main.Something.ViewModel(state: .error(message: error))
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
