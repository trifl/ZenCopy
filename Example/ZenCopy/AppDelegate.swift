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
        ZenCopy.manager.config.languages = ["sp", "en"]
        
        ZenCopy.manager.config.addCopy("en", prefix: "chat") {
            return [
                "dance": ["@$0 dances with themself"],
                "poke": ["@$0 ".style("token"), "pokes ".style("action"), "@$1".style("token")]
            ]
        }
        
        ZenCopy.manager.config.addCopy("en", prefix: "global") {
            return [
                "welcome": ["Welcome to ", "Bindle! ".style("token"), "Please send your feedback to ", "feedback@bindlechat.com".style("action")],
                "fun": ["$0".style("action"), "blah dee blah $1"]
            ]
        }
        
        ZenCopy.manager.config.addCopy("sp", prefix: "global") {
            return [
                "fun": ["$1 vee dah vee", "$0".style("action hulk")]
            ]
        }

        ZenCopy.manager.config.setStyles {
            return [
                "action": Style(
                    color: .lightGrayColor()
                ),
                "token": Style(
                    color: .greenColor()
                ),
                "hulk": Style (
                    fontSize: 40
                )
            ]
        }
    }
}

