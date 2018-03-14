import UIKit

public extension UIView {
    
    func shakeOff() {
        self.layer.removeAllAnimations()
    }
    
    func shakeOn(){
        
        self.layer.removeAllAnimations()
        
        let wiggleBounceY = 1.0
        let wiggleBounceDuration = 0.12
        let wiggleBounceDurationVariance = 0.024
        
        let wiggleRotateAngle = 0.02
        let wiggleRotateDuration = 0.10
        let wiggleRotateDurationVariance = 0.024
        
        func randomize(interval: TimeInterval, withVariance variance: Double) -> Double{
            let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
            return interval + variance * random
        }
        //Create rotation animation
        let rotationAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnim.values = [-wiggleRotateAngle, wiggleRotateAngle]
        rotationAnim.autoreverses = true
        rotationAnim.duration = randomize(interval: wiggleRotateDuration, withVariance: wiggleRotateDurationVariance)
        rotationAnim.repeatCount = HUGE
        
        //Create bounce animation
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounceAnimation.values = [wiggleBounceY, 0]
        bounceAnimation.autoreverses = true
        bounceAnimation.duration = randomize(interval: wiggleBounceDuration, withVariance: wiggleBounceDurationVariance)
        bounceAnimation.repeatCount = HUGE
        
        //Apply animations to view
        UIView.animate(withDuration: 0) {
            self.layer.add(rotationAnim, forKey: "rotation")
            self.layer.add(bounceAnimation, forKey: "bounce")
            self.transform = .identity
        }
    }
}
