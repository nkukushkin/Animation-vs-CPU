import UIKit

class AnimatingViewController: UIViewController {
    let animationDuration: TimeInterval = 30

    @IBOutlet weak var rectangleView: UIView!

    @IBAction func animate(_ sender: UIBarButtonItem) {
//        animateWithBasicAnimation()
        animateWithUIViewAnimation()
    }

    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
}

// MARK: - UIView Animation

extension AnimatingViewController {
    // UIView animation will stop when the view controller disappears, calling the completion.
    // If the animation repeats itself via completion, it will load the CPU with recursive calls
    // while the view controller is hidden, because completions will be called instantly.
    // When the view controller reappers the animations will start over.
    func animateWithUIViewAnimation() {
        print(#function)
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.rectangleView.transform = self.rectangleView.transform.rotated(by: .pi)
            }, completion: { _ in
                self.animateWithUIViewAnimation()
            })
    }
}

// MARK: - CABasicAnimation

extension AnimatingViewController {
    // CABasicAnimation will stop when when the view controller disappears
    // and, if it’s supposed to repeat, will start over when it appears.
    func animateWithBasicAnimation() {
        print(#function)
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.toValue = Double.pi * 2
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        animation.delegate = self
        rectangleView.layer.add(animation, forKey: nil)
    }
}

extension AnimatingViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print(#function)
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(#function)
    }
}
