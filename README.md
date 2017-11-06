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

if not want use all service , check service usage for installation each service

## Usage

```swift
import  Cips
```

```Objective-C
#import <Cips/Cips.h>
```

### Qnock Usage

Note that the `Firebase/Core` and `Firebase/Messaging` is required if using QNOCK SDK.

```ruby
pod 'Cips/Qnock', :git => 'http://gitlab.codigo.id/iOS/Chips.git'
```

##### Register Qnock
    Register qnock on appdelegate first using clientid and clientsecret from cms QNOCK.

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Qnock.initWithClientId(clientid, withClientSecret: clientsecret) { (token) in

    }
return true
}
```

##### Receiving Notification

    Use when notification received on device. This used on App Delegate 

```swift
func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    let data = Qnock.instance().notifReceived(userInfo)
}
```

##### Subscribe Channel
    
    This function use for subscribe or register new user id or new channel to qnock. 
    
    Userid on this function from userid member client not userid Qnock.

```swift
Qnock.instance().subscribe(FCMTOKEN, withChannel: channel, userID: userid) { (response) in
//complete register
}
```

##### Unsubscribe Channel
    This function to use unsubscribe or unregister channel from qnock. Use when user want to stop notification or user has logout.

```swift
Qnock.instance().unsubscribe(FCMTOKEN, withChannel: channel) { (response) in
//complete unsubscribe
}
```

#### Change Environment
    Change environment QNOCK PRODUCTION mode or SANDBOX mode

```swift
Qnock.setEnvironment(ENVIRONMENT)
````

### Squad Usage


```ruby
pod 'Cips/Squad', :git => 'http://gitlab.codigo.id/iOS/Chips.git'
```


## Author

iOS Codigo, ios@codigo.id

## License

Chips is available under the MIT license. See the LICENSE file for more info.
