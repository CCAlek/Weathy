//
//  Created by Semen Semenov on 21/10/2020.
//

protocol MainProviderProtocol {

    // Запрос получения ...
    func fetchItems(completion: @escaping(RequestResult<[MainModel]>) -> Void)
}

/// Отвечает за получение данных модуля Main
struct MainProvider: MainProviderProtocol {

    let dataStore: MainDataStore
    let service: MainServiceProtocol

    init(dataStore: MainDataStore = MainDataStore(), service: MainServiceProtocol = MainService()) {
        self.dataStore = dataStore
        self.service = service
    }

    // MARK: Запрос получения ...
    func fetchItems(completion: @escaping(RequestResult<[MainModel]>) -> Void) {
        if let items = dataStore.models, !items.isEmpty {
            return completion(.success(items))
        }
        service.fetchItems { result in
            completion(result)
        }
    }
}
