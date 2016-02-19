import UIKit
import ZenCopy

class ViewController: UIViewController {
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sender = "jp"
        let other = "joseph"
        
        let attributedText = NSMutableAttributedString(string: "Hello @linchpin")
        testLabel.numberOfLines = 0
        
        if let style = ZenCopy.manager.config.styles["token"] {
            attributedText.regexFind("(@[A-Za-z0-9_]*)", setStyle: style)
        }
        
        testLabel.attributedText = attributedText

        view.addSubview(testLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testLabel.frame.size.width = view.bounds.size.width - 40
        testLabel.sizeToFit()
        testLabel.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    }
}

