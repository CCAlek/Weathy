//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

enum Main {

    // MARK: Use cases ...
    enum Something {
        struct Request {
        }

        struct Response {
            var result: RequestResult<[MainModel]>
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case loading
        case result([Any/*viewModel*/])
        case emptyResult
        case error(message: String)
    }
}
