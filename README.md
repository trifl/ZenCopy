# ZenCopy

[![Version](https://img.shields.io/cocoapods/v/ZenCopy.svg?style=flat)](http://cocoapods.org/pods/ZenCopy)
[![License](https://img.shields.io/cocoapods/l/ZenCopy.svg?style=flat)](http://cocoapods.org/pods/ZenCopy)
[![Platform](https://img.shields.io/cocoapods/p/ZenCopy.svg?style=flat)](http://cocoapods.org/pods/ZenCopy)

ZenCopy is the last copy (text) manager you'll ever need. 
With ZenCopy you can:
- Style NSAttributedStrings with ease (1 line!)
- Regex search, then add styles to NSAttributedString with ease (1 line!)
- Localize NSAttributedStrings 
- Store all your strings in one place

## Installation
ZenCopy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZenCopy"
```

## Usage
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Copy
### Configuring Copy

You'll notice that Copy can include args. Simply use $0, $1, ... to set your args. Order within the text doesn't matter.
```swift
// english chat copy. prefix is for establishing context (optional)
ZenCopy.manager.config.addCopy("en", prefix: "chat") {
  return [
    "dance": ["@$0 dances with themself"], // note: this is chat.dance
  ]
}

// spanish chat copy
ZenCopy.manager.config.addCopy("sp", prefix: "chat") {
  return [
    "dance": ["@$0 baila con sí mismos"], // note: this is chat.dance
  ]
}
```

### Using Copy
NSAttributedString
```swift
myLabel.attributedText = ZenCopy.manager.attributedString(key: "global.fun", args: [sender, other])
```

## Styles
### Configuring Styles
```swift
ZenCopy.manager.config.setStyles {
    return [
        "action": Style(
            color: .lightGrayColor()
        ),
        "token": Style(
            color: .blueColor(),
            fontSize: 14
        ),
        "hulk": Style (
            color: .greenColor(),
            fontSize: 40
        )
    ]
}
```

### Set Style on NSAttributedString (with Regex!)
```swift
let atUserRegex = "(@[A-Za-z0-9_]*)"
mutableAttributedString.regexFind(atUserRegex, addStyle: "token")
```

### Styling in copy
In this example, chat.poke has arguments $0 and $1 styled as "token"
```swift
ZenCopy.manager.config.addCopy("en", prefix: "chat") {
  return [
    ...
    "poke": ["@$0 ".style("token"), "pokes ", "@$1".style("token")] // note: this is chat.poke
  ]
}
```

## Additional notes
I recommend storing all your strings in a Copy.swift (name it what you want) file within your project. I also recommend making use of the copy 'prefixes' to separate your keys by context (e.g. "global", "profile", "chat", etc.)

Let me know if you have any questions! Please submit feedback, issues, and pull requests :D

## Upcoming
- Have option to automatically set ZenCopy localization from device localization. Currently this is manual.
- Scripts to help you work with or migrate NSLocalizedStrings
- Clean integrations with other useful NSAttributedString libraries

## Author
JP McGlone, jp@trifl.co

## License
ZenCopy is available under the MIT license. See the LICENSE file for more info.
