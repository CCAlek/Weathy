//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainDisplayLogic: class {

    // Do something
    func displaySomething(viewModel: Main.Something.ViewModel)
}

class MainViewController: UIViewController {

    let interactor: MainBusinessLogic
    var state: Main.ViewControllerState

    init(interactor: MainBusinessLogic, initialState: Main.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
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
        doSomething()
    }

    // MARK: Do something
    func doSomething() {
        let request = Main.Something.Request()
        interactor.doSomething(request: request)
    }
}

extension MainViewController: MainDisplayLogic {

    // MARK: Do smth
    func displaySomething(viewModel: Main.Something.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: Main.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            print("result: \(items)")
        case .emptyResult:
            print("empty result")
        }
    }
}
