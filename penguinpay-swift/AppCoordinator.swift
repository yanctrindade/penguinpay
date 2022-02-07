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
        let viewModel = SendPaymentViewModel(countries: getCountriesData())
        let viewController = SendPaymentViewController(viewModel: viewModel)
        self.presenter = UINavigationController(rootViewController: viewController)
        self.appDelegate?.window = self.window
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    private func getCountriesData()-> [Country] {
        var countries: [Country]  = []
        countries.append(Country(name: "Kenya", currencyAbbreviation: "KES", phonePrefix: "+254", flag: "🇰🇪", digitsAfterPrefix: 9))
        countries.append(Country(name: "Nigeria", currencyAbbreviation: "NGN", phonePrefix: "+234", flag: "🇳🇬", digitsAfterPrefix: 7))
        countries.append(Country(name: "Tanzania", currencyAbbreviation: "TZS", phonePrefix: "+255", flag: "🇹🇿", digitsAfterPrefix: 9))
        countries.append(Country(name: "Uganda", currencyAbbreviation: "UGX", phonePrefix: "+256", flag: "🇺🇬", digitsAfterPrefix: 7))
        return countries
    }
    
}
