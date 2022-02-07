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
        uiController.delegate = self
        setupPickerView()
        viewModel.getRates()
    }

    private func setupPickerView() {
        uiController.countryPickerView.dataSource = self
        uiController.countryPickerView.delegate = self
        uiController.countryTextField.delegate = self
    }
}

extension SendPaymentViewController: SendPaymentViewDelegate {
    
    func sendMoneyButtonTapped() {
        print("send money method called on vc")
    }
    
}

extension SendPaymentViewController: UITextFieldDelegate {

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
    }
    
}
