import UIKit
import ZenCopy

class ViewController: UIViewController {
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sender = "linchpin"
        let other = "kriztoph"
        
        let attributedText = ZenCopy.manager.attributedString(key: "chat.poke", args: [sender, other])
        testLabel.attributedText = attributedText
        view.addSubview(testLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testLabel.sizeToFit()
        testLabel.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    }
}

