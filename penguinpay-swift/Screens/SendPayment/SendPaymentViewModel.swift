//
//  SendPaymentViewModel.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

class SendPaymentViewModel {
    
    let PICKER_COLUMNS_NUMBER = 1
    var countries:[Country]
    var rates: Rates?
    
    init(countries: [Country], rates: Rates) {
        self.countries = countries
        self.rates = rates
    }
    
    func getCountryTextForPickerViewFor(_ row: Int)-> String {
        let country = countries[row]
        return country.flag + country.name
    }
    
    func canChangeNumberString(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, phonePrefix: String?)-> Bool {
        guard let phonePrefix = phonePrefix,
            let countrySelected = findCountryWithPhonePrefix(phonePrefix) else {
            return false
        }
        
        guard !string.isEmpty else {
            return true
        }
        
        let newLength = textField.text?.count ?? 0 + string.count - range.length
        return newLength < countrySelected.digitsAfterPrefix
    }
    
    private func findCountryWithPhonePrefix(_ phonePrefix: String)-> Country? {
        return countries.first(where: {$0.phonePrefix == phonePrefix})
    }
}
