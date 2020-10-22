//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

enum Main {

    enum ViewControllerState {
        case loading
        case result([Any/*viewModel*/])
        case emptyResult
        case error(message: String)
    }
    
    // MARK: Получение местоположения пользователя
    enum GetUserLocation {
        struct Request {
        }

        struct Response {
            var result: MainMapLocationRequestResult
        }

        struct ViewModel {
            var state: MainMapViewState
        }
    }

    enum MainMapLocationRequestResult {
        case success(MainUserLocationCoordinateModel)
        case failure
        case permissionError
        case wait
    }
    
    enum MainMapViewState {
        case start
        case result(MainUserLocationCoordinateModel)
        case failure
        case permissionError
        case wait
    }
}
