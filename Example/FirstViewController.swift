//
//  FirstViewController.swift
//  Example
//
//  Created by Francis Lata on 2017-01-29.
//
//

import UIKit
import FullNavigationTransition

class FirstViewController: UIViewController {
    // MARK: Properties
    lazy var fullNavigationTransition: FullNavigationTransition = {
        let fullNavigationTransition = FullNavigationTransition()
        fullNavigationTransition.swipingThreshold = 0.25
        fullNavigationTransition.transitionDuration = 1.25
        
        return fullNavigationTransition
    }()
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: SecondViewController.self) {
            segue.destination.transitioningDelegate = fullNavigationTransition
            segue.destination.modalPresentationStyle = .custom
        }
    }
}
