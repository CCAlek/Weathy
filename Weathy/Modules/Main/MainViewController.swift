//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import FloatingPanel
import UIKit

protocol MainDisplayLogic: class {

    // Отображение местоположения пользователя
    func displayUserLocation(viewModel: Main.GetUserLocation.ViewModel)
    
    // Отображение данных о погоде
    func displayWeather(viewModel: Main.FetchWeather.ViewModel)
    
    // Отображение экрана подробной информации о погоде
    func displayWeatherScreen(viewModel: Main.NavigateToWeather.ViewModel)
}

protocol MainViewControllerDelegate: class {
    
    // Изменение координат центра карты
    func didChangeLocationCenterMapView(location: UserLocationCoordinateModel)
    
    // Переход к местоположению пользователя
    func navigateToUserLocation()
    
    // Переход к экрану подробной информации о погоде
    func navigateToWeather()
}

class MainViewController: UIViewController {

    let interactor: MainBusinessLogic
    var mapViewState: Main.MapViewState
    
    var tableDataSource = WeatherTableDataSource()
    var floatingPanelDelegate = FixedFloatingPanelDelegate()

    lazy var customView = self.view as? MainView
    var weatherTableView: UITableView?
    
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
    
    // MARK: Отображение экрана подробной информации о погоде
    func displayWeatherScreen(viewModel: Main.NavigateToWeather.ViewModel) {
        tableDataSource.representableViewModel = viewModel.result
        displayPanelView()
    }
    
    func displayPanelView() {
        if presentedViewController is FloatingPanelController {
            self.weatherTableView?.reloadData()
            return
        }
        
        let tableView = getWeatherTableView()
        self.weatherTableView = tableView
        floatingPanelDelegate.viewMetrics = FixedFloatingPanelViewMetrics(
            contentHeight: tableView.contentSize.height,
            estimatedRowHeight: tableView.estimatedRowHeight,
            numberOfRows: tableDataSource.representableViewModel.rows.count,
            viewHeight: view.frame.height,
            safeAreaTopInset: view.safeAreaInsets.top)
        
        let floatingPanelController = FloatingPanelController()
        floatingPanelController.delegate = floatingPanelDelegate
        let floatingPanelWorker = FloatingPanelWorker()
        floatingPanelWorker.present(tableView, with: self, panel: floatingPanelController)
    }
    
    private func getWeatherTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.clearWhite()
//        tableView.delegate = tableDelegate
        tableView.dataSource = tableDataSource
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.estimatedRowHeight = 60
        tableView.layoutIfNeeded()
        tableView.tableFooterView = UIView()
        return tableView
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
    
    // MARK: Переход к экрану подробной информации о погоде
    func navigateToWeather() {
        let request = Main.NavigateToWeather.Request()
        interactor.getWeather(request: request)
    }
}
