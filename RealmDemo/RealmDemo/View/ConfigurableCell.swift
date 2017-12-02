//
//  ConfigurableCell.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype T
    var model: T? { get set }
    func configure(with model : T)
}

