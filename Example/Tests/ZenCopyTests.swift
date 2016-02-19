// https://github.com/Quick/Quick

import Quick
import Nimble
import ZenCopy

class ZenCopyTests: QuickSpec {
    override func spec() {
        let copyManager = ZenCopy.manager
        let config = ZenCopy.Config()
        config.copy["en"] = [String:[CopyComponent]]()
        config.copy["en"]!["test1"] = ["Hello world!"]
        config.copy["en"]!["test2"] = ["Hello ", "world!".style("hulk")]
        config.copy["en"]!["test3"] = ["Hello $0!"]
        config.copy["en"]!["test4"] = ["Hello ", "$0", "!"]
        config.copy["en"]!["test5"] = ["@$0: hey @$1, it's me @$0"]
        
        //styles
        config.styles["hulk"] = Style(color: .greenColor(), font: .systemFontOfSize(200))
        config.styles["tiny"] = Style(font: .systemFontOfSize(8))
        
        copyManager.config = config
        
        describe("ZenCopy") {
            it("should work with key'") {
                expect(copyManager.string(key: "test1")) == "Hello world!"
            }
            it("should work on style value with key") {
                expect(copyManager.string(key: "test2")) == "Hello world!"
            }
            it("should work on style value works with args") {
                expect(copyManager.string(key: "test3", args: ["JP"])) == "Hello JP!"
            }
            it("should work on styled value works with multiple components args") {
                expect(copyManager.string(key: "test4", args: ["John"])) == "Hello John!"
            }
            it("should work with multiple args, even duplicates") {
                expect(copyManager.string(key: "test5", args: ["jpmcglone", "you"])) == "@jpmcglone: hey @you, it's me @jpmcglone"
            }
            it("string on the fly should work") {
                expect(copyManager.string(["Hello $0!"], args: ["JPM"])) == "Hello JPM!"
            }
        }
    }
}
