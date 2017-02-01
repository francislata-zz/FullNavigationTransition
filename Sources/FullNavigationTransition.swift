//
//  FullNavigationTransition.swift
//  FullNavigationTransition
//
//  Created by Francis Lata on 2017-01-28.
//
//

import Foundation

public class FullNavigationTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    // MARK: Properties
    
    /// This property indicates how long the transition should run for
    public var transitionDuration = 0.25
    
    /// This property indicates the amount, between 0.0 and 1.0, of when to trigger the dismissal animation of the view controller
    public var swipingThreshold: CGFloat = 0.5 {
        willSet {
            fullNavigationPercentDrivenInteractiveTransition.swipingThreshold = newValue
        }
    }
    
    fileprivate var isPresenting: Bool = true
    fileprivate let fullNavigationPercentDrivenInteractiveTransition = FullNavigationPercentDrivenInteractiveTransition()
    
    // MARK: UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        
        return self
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        isPresenting = false
        
        return fullNavigationPercentDrivenInteractiveTransition
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        if isPresenting {
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.transform = CGAffineTransform(translationX: toVC.view.frame.size.width, y: 0.0)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromVC.view.transform = CGAffineTransform.init(translationX: -(fromVC.view.frame.size.width / 4.0), y: 0.0)
                toVC.view.transform = CGAffineTransform.init(translationX: 0.0, y: 0.0)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                if !transitionContext.transitionWasCancelled {
                    self.fullNavigationPercentDrivenInteractiveTransition.interactiveViewController = toVC
                }
            })
        } else {
            transitionContext.containerView.addSubview(toVC.view)
            transitionContext.containerView.addSubview(fromVC.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromVC.view.transform = CGAffineTransform.init(translationX: fromVC.view.frame.size.width, y: 0.0)
                toVC.view.transform = CGAffineTransform.init(translationX: 0.0, y: 0.0)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                if !transitionContext.transitionWasCancelled {
                    // Fix issue where screen goes black after completing transition
                    UIApplication.shared.keyWindow?.addSubview(toVC.view)
                    
                    self.fullNavigationPercentDrivenInteractiveTransition.interactiveViewController = nil
                }
            })
        }
    }
}
