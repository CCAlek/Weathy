//
//  Created by Semen Semenov on 21/10/2020.
//

protocol MainServiceProtocol {

    // Запрос получения ...
    func fetchItems(completion: @escaping (RequestResult<[MainModel]>) -> Void)
}

/// Получает данные для модуля Main
class MainService: MainServiceProtocol {

    // MARK: Запрос получения ...
    func fetchItems(completion: @escaping (RequestResult<[MainModel]>) -> Void) {
    }
}
