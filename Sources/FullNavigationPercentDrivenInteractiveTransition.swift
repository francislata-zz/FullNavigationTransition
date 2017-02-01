//
//  FullNavigationPercentDrivenInteractiveTransition.swift
//  FullNavigationTransition
//
//  Created by Francis Lata on 2017-01-28.
//
//

import UIKit

class FullNavigationPercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: Properties
    var interactiveViewController: UIViewController? {
        didSet {
            guard let newViewController = interactiveViewController else { return }
            
            newViewController.view.addGestureRecognizer(panGestureRecognizer)
        }
    }
    var swipingThreshold = CGFloat(0.0)
    fileprivate lazy var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
    
    // MARK: IBAction methods
    @IBAction func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        guard let viewController = interactiveViewController else { return }
        
        let translation = panGestureRecognizer.translation(in: viewController.view)
        let velocity = panGestureRecognizer.velocity(in: viewController.view)
        
        switch sender.state {
            case .began:
                let isSwipingFromLeftToRight = (velocity.x > 0.0) ? true : false
                
                if isSwipingFromLeftToRight { viewController.dismiss(animated: true, completion: nil) }
            case .changed:
                update(translation.x / viewController.view.frame.size.width)
            case .ended:
                if percentComplete > swipingThreshold { finish() }
                else { fallthrough }
            case .cancelled:
                cancel()
            default:
                break
        }
    }
}
