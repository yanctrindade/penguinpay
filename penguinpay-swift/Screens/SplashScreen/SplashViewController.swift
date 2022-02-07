//
//  SplashViewController.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .systemGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    let apiClient = APIClient()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getRates()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func getRates() {
        apiClient.getRates { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rates):
                self.activityIndicator.stopAnimating()
                self.coordinator.splashToSendPayment(countries: self.getCountriesData(), rates: rates)
            case .failure(let error):
                self.presentAlert(title: "Ops ):", message: error.localizedDescription)
            }
        }
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
