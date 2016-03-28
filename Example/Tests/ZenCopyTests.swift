// https://github.com/Quick/Quick

import Quick
import Nimble
import ZenCopy

class ZenCopyTests: QuickSpec {
    override func spec() {
        let config = ZenCopy.Config()
        
        config.styles = { name in
            switch (name) {
            case "hulk":
                return Style(color: .greenColor(), fontSize: 200)
            case "tiny":
                return Style(fontSize: 8)
            default:
                return nil
            }
        }
        
        config.copy = { locale, key in
            switch (locale) {
            case "en":
                switch (key) {
                case "test1":
                    return ["Hello world!"]
                case "test2":
                    return ["Hello ", "world!".style("hulk")]
                case "test3":
                    return ["Hello $0!"]
                case "test4":
                    return ["Hello ", "$0", "!"]
                case "test5":
                    return ["@$0: ".style("token"), "hey @$1, it's me @$0"]
                case "test6":
                    return ["$0 blah blah $1"]
                case "profile.title":
                    return ["Profile"]
                case "profile.footer":
                    return ["Thanks!"]
                default:
                    return nil
                }
            case "sp":
                switch (key) {
                case "test6": return ["$1 y voy $0"]
                default:
                    return nil
                }
            default:
                return nil
            }
        }
        
        let copyManager = ZenCopy.Manager(config: config)

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
            it("should work in english") {
                expect(copyManager.string(key: "test6", args: ["jp", "joe"])) == "jp blah blah joe"
            }
            
            context("add copy") {
                it("works") {
                    expect(copyManager.string(key: "profile.title")) == "Profile"
                }
            }
        }
        
        describe("ZenCopy localization") {
            beforeEach {
                copyManager.config.languages = ["sp", "en"]
            }
            
            afterEach {
                copyManager.config.languages = ["en"]
            }
            
            it("should work in spanish") {
                expect(copyManager.string(key: "test6", args: ["jp", "joe"])) == "joe y voy jp"
            }
            
            it("should print the key if in none of the languages") {
                expect(copyManager.string(key: "global.doesntexist", args: ["jp", "joe"])) == "global.doesntexist"
            }
        }
    }
}
