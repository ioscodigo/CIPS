# Chips

[![CI Status](http://img.shields.io/travis/fajaraw/Chips.svg?style=flat)](https://travis-ci.org/fajaraw/Chips)
[![Version](https://img.shields.io/cocoapods/v/Chips.svg?style=flat)](http://cocoapods.org/pods/Chips)
[![License](https://img.shields.io/cocoapods/l/Chips.svg?style=flat)](http://cocoapods.org/pods/Chips)
[![Platform](https://img.shields.io/cocoapods/p/Chips.svg?style=flat)](http://cocoapods.org/pods/Chips)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 8

## Installation

Chips is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Cips', :git => 'http://gitlab.codigo.id/iOS/Chips.git'
```

## Usage

```swift
import  Cips
```

```Objective-C
#import <Cips/Cips.h>
```

### Qnock Usage

Note that the `Firebase/Core` and `Firebase/Messaging` is required if using QNOCK SDK.

##### Register Qnock

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Qnock.initWithClientId(clientid, withClientSecret: clientsecret) { (token) in

    }
return true
}
```

##### Receiving Notification

```swift
func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    let data = Qnock.instance().notifReceived(userInfo)
}
```

##### Subscribe Channel

```swift
Qnock.instance().subscribe(FCMTOKEN, withChannel: channel, userID: userid) { (response) in
//complete register
}
```

##### UnSubscribe Channel

```swift
Qnock.instance().unsubscribe(FCMTOKEN, withChannel: channel) { (response) in
//complete unsubscribe
}
```


### Squad Usage

## Author

iOS Codigo, ios@codigo.id

## License

Chips is available under the MIT license. See the LICENSE file for more info.
