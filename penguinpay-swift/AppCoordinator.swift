//
//  AppCoordinator.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

class AppCoordinator {
    
    private var presenter: UINavigationController
    private var window: UIWindow
    private weak var appDelegate: AppDelegate?
    
    init(appDelegate: AppDelegate, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
        self.presenter = UINavigationController()
    }
    
    func start() {
        let viewController = SplashViewController()
        self.presenter = UINavigationController(rootViewController: viewController)
        self.appDelegate?.window = self.window
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    func splashToSendPayment(countries: [Country], rates: Rates) {
        let viewModel = SendPaymentViewModel(countries: countries, rates: rates)
        let viewController = SendPaymentViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
}
