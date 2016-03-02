import UIKit
import ZenCopy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupZenCopy()
        return true
    }
    
    func englishCopy(key: String) -> [CopyComponent]? {
        switch (key) {
        case "dance":
            return ["@$0 dances with themself"]
        case "poke":
            return ["@$0 ".style("token"), "pokes ".style("action"), "@$1".style("token")]
        case "global.welcome":
            return ["Welcome to ", "Bindle! ".style("token"), "Please send your feedback to ", "feedback@bindlechat.com".style("action")]
        case "global.fun":
            ["@$0 ".style("action"), "blah dee blah @$1"]
        default:
            return nil
        }
        return nil // I don't understand why I need this line, since default is covered above =/
    }
    
    func spanishCopy(key: String) -> [CopyComponent]? {
        switch (key) {
        case "global.fun":
            return ["@$1 vee dah", "vee @$0".style("action hulk")]
        default: return nil
        }
    }
    
    func setupZenCopy() {
        ZenCopy.manager.config.languages = ["sp", "en"]
        
        ZenCopy.manager.config.copy = { locale, key in
            switch (locale) {
            case "en":
                return self.englishCopy(key)
            case "sp":
                return self.spanishCopy(key)
            default:
                return nil
            }
        }
        
        ZenCopy.manager.config.styles = { name in
            switch(name) {
            case "action":
                return Style(color: .lightGrayColor())
            case "token":
                return Style(color: .blueColor())
            case "large":
                return Style(fontSize: 40)
            case "underline":
                return Style(underline: true)
            case "ghost":
                return Style(alpha: 0.5)
            case "Username":
                return "token large"
            default:
                return nil
            }
        }
    }
}

