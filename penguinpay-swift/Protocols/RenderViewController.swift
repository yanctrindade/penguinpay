//
//  RenderViewController.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import Foundation

protocol RenderViewProtocol {
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension RenderViewProtocol {
    func setupView(){
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
