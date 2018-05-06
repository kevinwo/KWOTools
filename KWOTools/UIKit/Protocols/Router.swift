//
//  Router.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 3/27/18.
//

import UIKit

public protocol Router: NSObjectProtocol {

    associatedtype T: UIViewController
    static var storyboard: UIStoryboard { get }
    var view: T! { get set }
    init(view: T)
}
