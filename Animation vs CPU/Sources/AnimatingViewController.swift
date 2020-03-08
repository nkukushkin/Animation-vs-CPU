import UIKit

class AnimatingViewController: UIViewController {
    let animationDuration: TimeInterval = 30

    @IBOutlet var rectangleView: UIView!

    @IBAction func animate(_ sender: UIBarButtonItem) {
//        animateWithBasicAnimation()
        animateWithUIViewAnimation()
    }

    @IBAction func removeRectangle(_ sender: UIButton) {
        rectangleView.removeFromSuperview()
    }

    @IBAction func addRectangle(_ sender: UIButton) {
        view.addSubview(rectangleView)
        NSLayoutConstraint.activate([
            rectangleView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            rectangleView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
        ])
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
    // UIView animation will complete instantly, when the view is removed from the hierarchy.
    //
    // Note that we invoke this method recursively, this causes a high CPU load
    // of instantly completing calls to UIView.animate(:) while the view is not in the hierarchy.
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
    // CABasicAnimation will stop when when the view is removed from the hierarchy.
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
