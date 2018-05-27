#
# Be sure to run `pod lib lint Chips.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Cips'
  s.version          = '0.2.2'
  s.summary          = 'iOS SDK for Cips Service.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it

  s.description      = <<-DESC
iOS SDK for Cips Service.
DESC

  s.homepage         = 'https://github.com/ioscodigo/CIPS'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iOS Team' => 'ios@codigo.id' }
  s.source           = { :git => 'https://github.com/ioscodigo/CIPS.git', :tag => s.version.to_s }
  s.requires_arc	 = true
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.xcconfig       = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/"' }

 s.source_files = 'Cips/Core/Cips.{h,m}'
  
  # s.resource_bundles = {
  #   'Chips' => ['Chips/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.public_header_files = 'Cips/Core/Cips.h'
    # s.private_header_files = 'Cips/Squad/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking'

    s.subspec 'Core' do |core|
        core.source_files = 'Cips/Core/**/*.{h,m}'
        core.public_header_files = 'Cips/Core/*.h'
    # core.private_header_files = 'Cips/Core/*.h'
    end

    s.subspec 'Qnock' do |qnock|
        qnock.dependency	'Cips/Core'
        qnock.source_files = 'Cips/Qnock/**/*.{h,m}'
        qnock.private_header_files = ['Cips/Qnock/Internal/*.h']
    end
#    s.subspec 'Squad' do |squad|
#        squad.dependency	'Cips/Core'
#        squad.dependency 'SDWebImage', '~> 4.0'
#        squad.source_files = 'Cips/Squad/**/*.{h,m}'
#        squad.exclude_files = 'Cips/Squad/SquadSocial.h'
#  squad.weak_frameworks = 'TwitterKit'
#        squad.frameworks = 'Foundation', 'UIKit'
#        squad.resource_bundles = {
#            'CipsSquad' => ['Cips/Squad/Resource/**/*.{storyboard,xcassets,xib}']
#       }
#        squad.private_header_files = ['Cips/Squad/Internal/*.h','Cips/Squad/Views/*.h']
#    end

#    s.subspec 'SquadSocial' do |social|
#    social.dependency 'Cips/Squad'
#    social.subspec 'Facebook' do |fb|
#        fb.dependency 'FBSDKLoginKit', '~> 4.25.0'
#   end
# end


   s.subspec 'Hearsay' do |hearsay|
       hearsay.dependency     'Cips/Core'
       hearsay.source_files = 'Cips/Hearsay/**/*.{h,m}'
       hearsay.private_header_files = ['Cips/Hearsay/Internal/*.h']
   end

    s.subspec 'Spotlight' do |spotlight|
        spotlight.dependency     'Cips/Core'
        spotlight.source_files = 'Cips/Spotlight/**/*.{h,m}'
        spotlight.private_header_files = ['Cips/Spotlight/Internal/*.h']
    end
end
