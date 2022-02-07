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
        uiController.delegate = self
        title = "Send Transaction"
    }

}

extension SendPaymentViewController: SendPaymentViewDelegate {
    
    func sendMoneyButtonTapped() {
        print("send money method called on vc")
    }
    
}
