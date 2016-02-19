// https://github.com/Quick/Quick

import Quick
import Nimble
import ZenCopy

class ZenCopyTests: QuickSpec {
    override func spec() {
        let copyManager = ZenCopy.manager
        
        copyManager.copy["en"] = [String:[CopyComponent]]()
        copyManager.copy["en"]!["test1"] = ["Hello world!"]
        copyManager.copy["en"]!["test2"] = ["Hello ", "world!".style("hulk")]
        copyManager.copy["en"]!["test3"] = ["Hello $0!"]
        copyManager.copy["en"]!["test4"] = ["Hello ", "$0", "!"]
        copyManager.copy["en"]!["test5"] = ["@$0: hey @$1, it's me @$0"]

        
        //styles
        copyManager.styles["hulk"] = Style(color: .greenColor(), font: .systemFontOfSize(200))
        copyManager.styles["tiny"] = Style(font: .systemFontOfSize(8))
        
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
