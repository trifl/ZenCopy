import UIKit
import ZenCopy

class ViewController: UIViewController {
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sender = "jp"
        let other = "joseph"
        
        let attributedText = ZenCopy.manager.attributedString(key: "global.fun", args: [sender, other])
        testLabel.attributedText = attributedText
        testLabel.numberOfLines = 0
        view.addSubview(testLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testLabel.frame.size.width = view.bounds.size.width - 40
        testLabel.sizeToFit()
        testLabel.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    }
}

