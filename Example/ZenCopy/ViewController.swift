import UIKit
import ZenCopy

class ViewController: UIViewController {
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.numberOfLines = 0

        let mutableAttributedString = NSMutableAttributedString(string: "@test says hit to @other")
        
        let atUserRegex = "(@[A-Za-z0-9_]*)"
        mutableAttributedString.regexFind(atUserRegex, addStyle: "Username")
        
        testLabel.attributedText = mutableAttributedString

        view.addSubview(testLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testLabel.frame.size.width = view.bounds.size.width - 40
        testLabel.sizeToFit()
        testLabel.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    }
}

