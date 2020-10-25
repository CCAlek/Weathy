//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainDisplayLogic: class {

    // Отображение местоположения пользователя
    func displayUserLocation(viewModel: Main.GetUserLocation.ViewModel)
    
    // Отображение данных о погоде
    func displayWeather(viewModel: Main.FetchWeather.ViewModel)
}

protocol MainViewControllerDelegate: class {
    
    // Изменение координат центра карты
    func didChangeLocationCenterMapView(location: UserLocationCoordinateModel)
    
    // Переход к местоположению пользователя
    func navigateToUserLocation()
}

class MainViewController: UIViewController {

    let interactor: MainBusinessLogic
    var mapViewState: Main.MapViewState

    lazy var customView = self.view as? MainView
    
    init(interactor: MainBusinessLogic,
         mapViewState: Main.MapViewState = .start) {
        self.interactor = interactor
        self.mapViewState = mapViewState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MainView(frame: UIScreen.main.bounds, delegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        display(newMapViewState: mapViewState)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView?.setupOrientationLayout()
    }

    // MARK: Получение местоположения пользователя
    func getUserLocation() {
        let request = Main.GetUserLocation.Request()
        interactor.getUserLocation(request: request)
    }
    
    // MARK: Получение данных о погоде
    func fetchWeather(location: UserLocationCoordinateModel) {
        let request = Main.FetchWeather.Request(location: location)
        interactor.fetchWeather(request: request)
    }
}

extension MainViewController: MainDisplayLogic {

    // MARK: Отображение местоположения пользователя
    func displayUserLocation(viewModel: Main.GetUserLocation.ViewModel) {
        display(newMapViewState: viewModel.state)
    }

    func display(newMapViewState: Main.MapViewState) {
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
    
    // MARK: Отображение данных о погоде
    func displayWeather(viewModel: Main.FetchWeather.ViewModel) {
        switch viewModel.state {
        case let .result(weather):
            customView?.configure(with: weather)
        case let .failure(error):
            print("Error display weather data: \(error)")
        }
    }
}

extension MainViewController: MainViewControllerDelegate {
    // MARK: Изменение координат центра карты
    func didChangeLocationCenterMapView(location: UserLocationCoordinateModel) {
        fetchWeather(location: location)
    }
    
    // MARK: Переход к местоположению пользователя
    func navigateToUserLocation() {
        getUserLocation()
    }
}
