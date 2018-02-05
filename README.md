
# Chips

[![CI Status](http://img.shields.io/travis/fajaraw/Chips.svg?style=flat)](https://travis-ci.org/fajaraw/Chips)
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
pod 'Cips/Qnock'
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
pod 'Cips/Squad'
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
    
### SpotLight Usage

#### Login
    This function to init squad on first time app run
    
    ```swift
        [Spotlight initWithAppsSecret:APPS_SECRET withClientId:APPS_ID withCompanyId:COMPANY_ID completion:^(bool isSuccess, NSString                         *responseToken) {
            NSLog(@"LOGIN SPOTLIGHT %@",responseToken);
        }];
    ```
   
#### Channel List
    This function get channel list
```swift

```

##### Homepage
    List function to get list article homepage by type and channel
 - Homepage Headline with Channel
 ```swift
[Spotlight.instance spotlightHomepageHeadlineWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                
    }];
```
-   Homepage Story with Channel
```swift
[Spotlight.instance spotlightHomepageStoryWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
        
}];
```
- Homepage Editor with Channel
```swift
[Spotlight.instance spotlightHomepageEditorChoiceWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
              
}];
```
- Homepage Newsboost with Channel
```swift
[Spotlight.instance spotlightHomepageNewsboostWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
              
}];
```
- Homepage Commercial with Channel
```swift
[Spotlight.instance spotlightHomepageCommercialWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
        
}];
```

- Homepage Boxtype with Channel
```swift
[Spotlight.instance spotlightHomepageBoxTypeWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                
}];
```

#### Article 

    List function to get list article by type
    
- Basic List Article
```swift
[Spotlight.instance spotlightArticleWithWithUserId:@"guset" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
               
}];
```
- Basic List Article with Channel
```swift
[Spotlight.instance spotlightArticleWithChannel:channelNo withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
           
}];
```

- Standard List Article
```swift
[Spotlight.instance spotlightArticleStandardWithUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
              
}];
```
- Standard List Article with Channel
```swift
[Spotlight.instance spotlightArticleStandardWithChannel:channelNo withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                
}];
```

-  List Article Gallery 
```swift
[Spotlight.instance spotlightArticleGalleryWithUserId:@"guest" withPage:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
               
}];
```
- List Article Gallery with Channel
```swift
[Spotlight.instance spotlightArticleGalleryWithChannel:channelNo withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                
}];
```
- List Article Group
```swift
[Spotlight.instance spotlightArticleGroupWithUserId:@"guest" withPage:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
        
}];
```
- List Article Group with Channel
```swift
[Spotlight.instance spotlightArticleGroupWithChannel:channelNo withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
        
}];
```
- List Article Around me
```swift
[Spotlight.instance spotlightArticleAroundMeWithLatitude:@"latitude cordinate" longitude:@"longitude cordinate" radius:@"10" withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {

}];
```
- Detail Article
    This function to get Detail article
```swift
[Spotlight.instance spotlightArticleDetailWithId:_article_id withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {
        
}];
```

- Share Article
    This function to share article
```swift
[Spotlight.instance spotlightArticleShareWithArticleNo:article_no withUserId:@"guset" type:@"2" fromEmail:@"abc@codigo.id" toEmail:@"test2@codigo.id" message:@"test" onComplete:^(SpotlightResponseModel *response) {
        
}];
```

#### Live Streaming
- List Live Streaming with Channel
    This function to get list live streaming
```swift
[Spotlight.instance spotlightLiveStreamingWithChannel:channelNo withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {

}];
```

- Share Live Streaming
    This function to share live streaming
```swift
[Spotlight.instance spotlightLiveStreamingShareWithStreamingId:live_streaming_no userid:@"guest" shareType:@"2" fromEmail:@"test@mailhog.codigo.id" toEmail:@"test2@mailhog.codigo.id" message:@"msg" onComplete:^(SpotlightResponseModel *response) {

}];
```

#### Reaction
- List Reaction on Article
    This function to get list Reaction
```swift
 [Spotlight.instance spotlightReactionListWithArticleId:article_no withUserId:@"guest" onComplete:^(SpotlightResponseModel *respon) {

}];
```

- Submit Reaction on Article
    This function to submit Reaction
```swift
[Spotlight.instance spotlightReactionSubmitWithArticleId:article_no withReactionNo:@"2" withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {

}];
```

#### Story
- List Story without channel
    This function to get list story without channel
```swift
[Spotlight.instance spotlightStoryListWithUserid:@"guest" page:0 limit:10 limitArticle:@"10" onComplete:^(SpotlightResponseModel *response) {

}];
```

- List Story with Channel
    This function to get list story with channel
```swift
[Spotlight.instance spotlightStoryListWithChannel:channel_no withUserId:@"guest" page:0 limit:10 limitArticle:@"10" onComplete:^(SpotlightResponseModel *response) {
        
}];
```

- Detail Story
    This function to get story detail
```swift
[Spotlight.instance spotlightStoryDetailWithStoryNo:_story_no withUserId:@"guest" limitArticle:10 onComplete:^(SpotlightResponseModel *response) {
     
}];
```


## Author

iOS Codigo, ios@codigo.id

## License

Chips is available under the MIT license. See the LICENSE file for more info.
