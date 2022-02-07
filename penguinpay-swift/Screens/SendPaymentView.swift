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
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var nameLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        view.text = "Recipient:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var firstNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "First Name"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lastNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Last Name"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var countryLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        view.text = "Country:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var countryTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Select your Country"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var horizontalStackview: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var phoneLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        view.text = "Phone:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var countryCodeLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.text = "+55"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var phoneTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Phone"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var amounToSendtLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        view.text = "Amount to send in Binaria:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var amountToSendTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "010101"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var sendButton: UIButton = {
        var view = UIButton()
        view.setTitle("SEND", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sendMoney), for: .touchUpInside)
        return view
    }()
    
    @objc func sendMoney() {
        self.delegate?.sendMoneyButtonTapped()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        horizontalStackview.addArrangedSubview(countryCodeLabel)
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
