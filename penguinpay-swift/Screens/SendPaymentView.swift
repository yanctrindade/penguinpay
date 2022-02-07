//
//  SendPaymentView.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

protocol SendPaymentViewDelegate : AnyObject {
    func sendMoneyButtonTapped()
}

class SendPaymentView: UIView {
    
    weak var delegate: SendPaymentViewDelegate?
    
    var verticalStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Recipient:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var countryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Country:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select your Country"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = countryPickerView
        textField.tintColor = .clear
        
        var pickerAccessory = UIToolbar()
        pickerAccessory.autoresizingMask = .flexibleHeight
        var frame = pickerAccessory.frame
        frame.size.height = 44.0
        pickerAccessory.frame = frame
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked(_:)))
        pickerAccessory.items = [flexSpace, flexSpace, doneButton]
        textField.inputAccessoryView = pickerAccessory
        
        return textField
    }()
    
    var countryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var activityTypeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Select Activity Type"
        textField.borderStyle = .roundedRect
        
        var pickerAccessory = UIToolbar()
        pickerAccessory.autoresizingMask = .flexibleHeight
        var frame = pickerAccessory.frame
        frame.size.height = 44.0
        pickerAccessory.frame = frame
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked(_:)))
        pickerAccessory.items = [flexSpace, flexSpace, doneButton]
        textField.inputAccessoryView = pickerAccessory
        
        return textField
    }()
    
    var horizontalStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var phoneLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Phone:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneCountryCodeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "+55"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var amounToSendtLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Amount to send in Binaria:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var amountToSendTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "010101"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var sendButton: UIButton = {
        var button = UIButton()
        button.setTitle("SEND", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendMoney), for: .touchUpInside)
        return button
    }()
    
    @objc func sendMoney() {
        self.delegate?.sendMoneyButtonTapped()
    }
    
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        countryTextField.resignFirstResponder()
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        countryTextField.resignFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCountryText(text: String) {
        countryTextField.text = text
        countryPickerView.resignFirstResponder()
    }
    
}

extension SendPaymentView: RenderViewProtocol {
    
    func setupViewHierarchy() {
        verticalStackview.addArrangedSubview(nameLabel)
        verticalStackview.addArrangedSubview(firstNameTextField)
        verticalStackview.addArrangedSubview(lastNameTextField)
        verticalStackview.addArrangedSubview(countryLabel)
        verticalStackview.addArrangedSubview(countryTextField)
        verticalStackview.addArrangedSubview(phoneLabel)
        horizontalStackview.addArrangedSubview(phoneCountryCodeLabel)
        horizontalStackview.addArrangedSubview(phoneTextField)
        verticalStackview.addArrangedSubview(horizontalStackview)
        verticalStackview.addArrangedSubview(amounToSendtLabel)
        verticalStackview.addArrangedSubview(amountToSendTextField)
        verticalStackview.addArrangedSubview(sendButton)
        
        addSubview(verticalStackview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            verticalStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            verticalStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .secondarySystemBackground
    }
    
}
