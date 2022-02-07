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
    
    func findCountryWithPhonePrefix(_ phonePrefix: String)-> Country? {
        return countries.first(where: {$0.phonePrefix == phonePrefix})
    }
    
    func validateBinaryInput(input: String) -> Bool{
        if input.isEmpty {
            return true
        }else{
            let regex = "[0-1]"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
        }
    }
    
    func convertAmount(binaryValue: String?, country: Country?) -> String? {
        guard let binaryValue = binaryValue,
            let countrySelected = country,
              let rate = rates?.rates[countrySelected.currencyAbbreviation] else {
            return nil
        }
        
        guard let intValue = Int(binaryValue, radix: 2) else {
            return nil
        }
        let exchangedValue = Float(intValue) * rate
        
        if exchangedValue > Float(Int.max) {
            return "Max Value Reached"
        } else {
            return String(Int(exchangedValue), radix: 2)
        }
    }
}
