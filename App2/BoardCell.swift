//
//  BoardCell.swift
//  App2
//
//  Created by Robert MacInnis on 8/9/23.
//

import UIKit

class BoardCell : UICollectionViewCell {
    
    @IBOutlet weak var Image: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan?")
        
        super.touchesBegan(touches, with: event)
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
//            usingSpringWithDamping: 1.0,
//            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction, .beginFromCurrentState, .curveLinear],
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                print("animating?")
            },
            completion: nil
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        super.touchesEnded(touches, with: event)
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
//            usingSpringWithDamping: 1.0,
//            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.transform = .identity
            },
            completion: nil
        )
    }
}
