# Chips

#[![CI Status](http://img.shields.io/travis/fajaraw/Chips.svg?style=flat)](https://travis-ci.org/fajaraw/Chips)
[![Version](https://img.shields.io/cocoapods/v/Chips.svg?style=flat)](http://cocoapods.org/pods/CIPS)
[![License](https://img.shields.io/cocoapods/l/Chips.svg?style=flat)](http://cocoapods.org/pods/CIPS)
[![Platform](https://img.shields.io/cocoapods/p/Chips.svg?style=flat)](http://cocoapods.org/pods/CIPS)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 8

## Installation

Chips is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'Cips'
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

#### Init Squad
	Init Squad on appdelegate first using clientid and clientsecret from cms Squad.

	```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Squad.initWithClientId(clientid, withClientSecret: clientsecreet withCompanyId: companyid)
return true
}
```

#### List Function

##### Login
	This function to login on squad
	```swift
	Squad.instance().login(withEmail: email, andPassoword: password) { (respon) in
        //respon on squad 
        //get token an refresh token   
     }
	```
##### Register
	This function to register on squad
	```swift
	Squad.instance().registerFirst(withEmail: email, password: pass, firstName: firstname, lastName: lastname, companyid: companyid, redirecturi: reduri, verifyuri: veriuri) { (respon) in
            //respon on squad
        }
     ```
     note redirect uri and verfyuri can use from squad or make self

##### Get User Info 
	This function to get user info profile
	```swift
	Squad.instance().userInfoGet(withToken: token) { (respon) in
            //respon on squad
        }
    ```
##### Edit Profile
	This function to edit profile squad
	```swift
	Squad.instance().profileEdit(withData: data) { (respon) in
            
        }
    ```
    This field data format to send on profile edit, but not all field to insert, its depend on client and cms
    ```swift
		let data = [
                    "access_token":"token",
                    "user_id":"userid",
                    "phone_number":"number",
                    "first_name":"first",
                    "last_name":"last",
                    "birth_place":"place",
                    "address":"address",
                    "country":"countryid",
                    "city":"cityid",
                    "zip":"zipcode",
                    "gender":"genderid",
                    "birth_date":"date"
                    ]
    ```

    note : gender id = 2 : male , 1 : female
    You can get country list and city list include id from this function
    ```swift
    	Squad.instance().getListCountry { (respon) in
            //list country
        }

        Squad.instance().getListCity(withCountryId: countryid) { (respon) in
         	//list city   
        }
    ```
    Date format for birthdate is YYYY-MM-dd

##### Update profile picture
	This function to update profile picture squad user
	```swift
	Squad.instance().uploadImage(imageData, userid: userid, accessToken: token) { (respon) in
        //Respon Squad
        }
    ```

##### Refresh Token
	This function to refresh token if token expired
	```swift
	Squad.instance().tokenRefresh(withToken: refresh_token) { (respon) in
     	//Respon Squad
     	//update accesstoken and refreshtoken     
        }
    ```

##### Logout
	This function to logout user squad
	```swift
	Squad.instance().logoutAccessToken(access_token, refreshToken: refresh_token) { (respon) in
       //Respon Squad     
        }
    ```
##### Get user info for edit profile
	This function to get user info for edit profile, respon field different each client
	```swift
		Squad.instance().resourceWithParamsGet(withToken: access_token) { (respon) in
         //Respon Squad   
        }
	```

##### Forgot Password
	This function to get forgot password
	```swift
	Squad.instance().passwordForgot(withUserid: "", email:email, verifyUrl: verifyuri, redirectUrl: redirecturi) { (respon) in
       //Respon Squad     
        }
    ```
    note: you can leave userid empty string
 
##### Update Password
	This function to update password user squad
	```swift
	Squad.instance().passwordUpdate(withAccessToken: access_token, userid: userid, oldPassword: oldPass, newPassword: newPass) { (respon) in
            //Respon Squad
        }
    ```

##### Update Email
    This function to update email user squad
    ```swift
    Squad.instance().emailUpdate(withAccessToken: access_token, userid: userid, newEmail: email, password: password) { (respon) in
            //Respon Squad   
        }
    ```

#### List View Controller Squad
	Squad provide basic view controller you can use for login, register, update profile , etc. This list fuction to show view controll from squad

#### Login View Controller
	This to use login , register and forgot password from squad
	```swift
        SquadViewHelper.squadLoginView(with: view_controller, delegate: delegate)
    ```

    Squad Controller Delegate
    ```swift
    func squadLoginResponse(_ data: [AnyHashable : Any]!, status isSuccees: Bool, message: String!, controller: UIViewController!) {
        
    }
    ```
#### Profile View Controller
	This to use view profile, edit profile and change profile picture squad
	```swift
        SquadViewHelper.squadProfileView(with: view_controller, token: token)
    ```

## Author

iOS Codigo, ios@codigo.id

## License

Chips is available under the MIT license. See the LICENSE file for more info.
