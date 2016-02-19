// https://github.com/Quick/Quick

import Quick
import Nimble
import ZenCopy

class ZenCopyTests: QuickSpec {
    override func spec() {
        let copyManager = ZenCopy.manager
        let config = ZenCopy.Config()
        
        config.setStyles {
            return [
                "hulk": Style(color: .greenColor(), fontSize: 200),
                "tiny": Style(fontSize: 8)
            ]
        }
        
        config.setCopy("en") {
            return [
                "test1": ["Hello world!"],
                "test2": ["Hello ", "world!".style("hulk")],
                "test3": ["Hello $0!"],
                "test4": ["Hello ", "$0", "!"],
                "test5": ["@$0: ".style("token"), "hey @$1, it's me @$0"],
                "test6": ["$0 blah blah $1"]
            ]
        }

        config.addCopy("en", prefix: "profile") {
            return [
                "title": ["Profile"],
                "footer": ["Thanks!"]
            ]
        }

        config.setCopy("sp") {
            return [
                "test6": ["$1 y voy $0"]
            ]
        }
        
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
