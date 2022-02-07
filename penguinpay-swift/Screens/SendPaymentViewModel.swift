//
//  SendPaymentViewModel.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import Foundation

class SendPaymentViewModel {
    
    let PICKER_COLUMNS_NUMBER = 1
    let apiClient = APIClient()
    var countries:[Country]
    
    init(countries: [Country]) {
        self.countries = countries
    }
    
    func getCountryTextForPickerViewFor(_ row: Int)-> String {
        let country = countries[row]
        return country.flag + country.name
    }
    
    func getRates() {
        apiClient.getRates { [weak self] result in
            switch result {
            case .success(let rates):
                print(rates.rates.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
