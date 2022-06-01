//
//  BlackStyleNavigationBarBehavior.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 26/05/2020.
//

import UIKit

public struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    public func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.barStyle = .black
    }
	
	public init(){}
}
