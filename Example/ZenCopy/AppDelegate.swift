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
        ZenCopy.manager.config.addCopy("en", prefix: "chat") {
            return [
                "dance": ["@$0 dances with themself"],
                "poke": ["@$0 ".style("token"), "pokes ".style("action"), "@$1".style("token")]
            ]
        }

        ZenCopy.manager.config.setStyles {
            return [
                "action": Style(
                    color: .lightGrayColor()
                ),
                "token": Style(
                    color: .greenColor()
                )
            ]
        }
    }
}

