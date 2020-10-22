//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainDisplayLogic: class {

    // Отображение местоположения пользователя
    func displayUserLocation(viewModel: Main.GetUserLocation.ViewModel)
}

class MainViewController: UIViewController {

    let interactor: MainBusinessLogic
    var state: Main.ViewControllerState
    var mapViewState: Main.MainMapViewState

    lazy var customView = self.view as? MainView
    
    init(interactor: MainBusinessLogic,
         initialState: Main.ViewControllerState = .loading,
         mapViewState: Main.MainMapViewState = .start) {
        self.interactor = interactor
        self.state = initialState
        self.mapViewState = mapViewState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MainView(frame: UIScreen.main.bounds)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        display(newMapViewState: mapViewState)
    }

    // MARK: Получение местоположения пользователя
    func getUserLocation() {
        let request = Main.GetUserLocation.Request()
        interactor.getUserLocation(request: request)
    }
}

extension MainViewController: MainDisplayLogic {

    // MARK: Отображение местоположения пользователя
    func displayUserLocation(viewModel: Main.GetUserLocation.ViewModel) {
        display(newMapViewState: viewModel.state)
    }

    func display(newMapViewState: Main.MainMapViewState) {
        mapViewState = newMapViewState
        switch mapViewState {
        case .start:
            getUserLocation()
        case let .result(location):
            customView?.displayUserLocation(location: location)
        case .failure:
            print("Error display user location")
        case .permissionError:
            print("Permission error get user location")
        case .wait:
            print("Wait display user location")
        }
    }
}
