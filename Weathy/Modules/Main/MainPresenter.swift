//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainPresentationLogic {

    // Показ местоположения пользователя
    func presentUserLocation(response: Main.GetUserLocation.Response)
}

/// Отвечает за отображение данных модуля Main
class MainPresenter: MainPresentationLogic {

    weak var viewController: MainDisplayLogic?

    // MARK: Показ местоположения пользователя
    func presentUserLocation(response: Main.GetUserLocation.Response) {
        var viewModel: Main.GetUserLocation.ViewModel
        
        switch response.result {
        case .failure:
            viewModel = Main.GetUserLocation.ViewModel(state: .failure)
        case let .success(result):
            viewModel = Main.GetUserLocation.ViewModel(state: .result(result))
        case .permissionError:
            viewModel = Main.GetUserLocation.ViewModel(state: .permissionError)
        case .wait:
            viewModel = Main.GetUserLocation.ViewModel(state: .wait)
        }
        
        viewController?.displayUserLocation(viewModel: viewModel)
    }
}
