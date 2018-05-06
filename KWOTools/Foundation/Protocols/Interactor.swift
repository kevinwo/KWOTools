//
//  Interactor.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 4/21/18.
//

import Foundation

public protocol Interactor: class {

    associatedtype T: Presenter
    var output: T! { get set }
    init(output: T)
}
