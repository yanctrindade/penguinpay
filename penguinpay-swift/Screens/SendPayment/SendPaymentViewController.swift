//
//  ViewController.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

class SendPaymentViewController: UIViewController {
    
    let uiController: SendPaymentView
    let viewModel: SendPaymentViewModel
    
    init(viewModel: SendPaymentViewModel) {
        self.viewModel = viewModel
        uiController = SendPaymentView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Transaction"
        setupUI()
    }

    private func setupUI() {
        navigationItem.hidesBackButton = true
        uiController.delegate = self
        uiController.countryPickerView.dataSource = self
        uiController.countryPickerView.delegate = self
        uiController.amountToSendTextField.delegate = self
        uiController.phoneTextField.delegate = self
        let firstElement = 0
        uiController.setCountryText(text: viewModel.getCountryTextForPickerViewFor(firstElement))
        uiController.phoneCountryCodeLabel.text = viewModel.countries[firstElement].phonePrefix
    }
    
}

extension SendPaymentViewController: SendPaymentViewDelegate {
    
    func sendMoneyButtonTapped() {
        guard !uiController.checkBlankFields() else {
            presentAlert(title: "Ops", message: "There are blank fields")
            return
        }
        let country = viewModel.findCountryWithPhonePrefix(uiController.phoneCountryCodeLabel.text ?? "")
        let result = viewModel.convertAmount(binaryValue: uiController.amountToSendTextField.text, country: country)
        guard let result = result else { return }
        uiController.resultLabel.text = "The recipient will receive: \(result)"
    }
    
}

extension SendPaymentViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == uiController.phoneTextField {
            let country = viewModel.findCountryWithPhonePrefix(uiController.phoneCountryCodeLabel.text ?? "")
            return viewModel.canChangeNumberString(textField: textField,
                                                   replacementString: string,
                                                   country: country)
        } else if textField == uiController.amountToSendTextField {
            return viewModel.validateBinaryInput(input: string)
        } else{
            return true
        }
    }
}

extension SendPaymentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.PICKER_COLUMNS_NUMBER
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countries.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getCountryTextForPickerViewFor(row)
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        uiController.setCountryText(text: viewModel.getCountryTextForPickerViewFor(row))
        uiController.phoneCountryCodeLabel.text = viewModel.countries[row].phonePrefix
        uiController.phoneTextField.text = nil
    }
    
}
