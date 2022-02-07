//
//  SendPaymentViewModel.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

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
    
    func canChangeNumberString(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, phonePrefix: String?)-> Bool {
        guard let phonePrefix = phonePrefix,
            let countrySelected = findCountryWithPhonePrefix(phonePrefix) else {
            return false
        }
        if string.isEmpty {
            return true
        } else {
            let newLength = textField.text?.count ?? 0 + string.count - range.length
            return newLength < countrySelected.digitsAfterPrefix
        }
    }
    
    private func findCountryWithPhonePrefix(_ phonePrefix: String)-> Country? {
        return countries.first(where: {$0.phonePrefix == phonePrefix})
    }
}
