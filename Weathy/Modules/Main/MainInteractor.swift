//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

protocol MainBusinessLogic {

    // Do something ...
    func doSomething(request: Main.Something.Request)
}

/// Класс для описания бизнес-логики модуля Main
class MainInteractor: MainBusinessLogic {

    let presenter: MainPresentationLogic
    let provider: MainProviderProtocol

    init(presenter: MainPresentationLogic, provider: MainProviderProtocol = MainProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func doSomething(request: Main.Something.Request) {
        provider.fetchItems { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.presenter.presentSomething(response: Main.Something.Response(result: result))
        }
    }
}
