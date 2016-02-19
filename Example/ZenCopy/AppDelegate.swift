import UIKit
import ZenCopy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupZenCopy()
        return true
    }
    
    func setupZenCopy() {
        ZenCopy.manager.config.setStyles {
            return [
                "token": Style(color: .greenColor()),
                "hulk": Style(font: .systemFontOfSize(80))
            ]
        }
    }
}

