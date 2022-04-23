//
//  ViewExtension.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import Lottie
import UIKit

extension UIView {
    func addAnimation(_ sourceName: String, animationMode: LottieLoopMode = .loop, width: CGFloat, height: CGFloat ,completion: (() -> Void)? = nil) {
        let animationView = AnimationView(name: sourceName)
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.addSubview(animationView)
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.loopMode = animationMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play { _ in
            completion?()
        }
    }
    
    func addPlaceholderAnimation(_ sourceName: String, animationMode: LottieLoopMode = .loop, completion: (() -> Void)? = nil) {
        let animationView = AnimationView(name: sourceName)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        
        self.addSubview(animationView)
        animationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        animationView.loopMode = animationMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play { _ in
            completion?()
        }
    }
    
    func animateViewCellTap(isHighlighted: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if isHighlighted {
                self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            } else {
                self.transform = .identity
            }
        })
    }
}
