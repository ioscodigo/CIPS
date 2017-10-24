#
# Be sure to run `pod lib lint Chips.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Cips'
  s.version          = '0.1.0'
  s.summary          = 'iOS SDK for Cips Service.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS SDK for Cips Service.
DESC

  s.homepage         = 'http://git.cips.stg.codigo.id/root/CipsiOS-SDK'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iOS Team' => 'ios@codigo.id' }
  s.source           = { :git => 'http://git.cips.stg.codigo.id/root/CipsiOS-SDK.git', :tag => s.version.to_s }
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
#  s.private_header_files = 'Cips/Squad/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking'

    s.subspec 'Core' do |core|
        core.source_files = 'Cips/Core/**/*.{h,m}'
        core.public_header_files = 'Cips/Core/*.h'
    # core.private_header_files = 'Cips/Core/*.h'
    end

    s.subspec 'Squad' do |squad|
        squad.dependency	'Cips/Core'
        squad.source_files = 'Cips/Squad/**/*.{h,m}'
        squad.resource_bundles = {
            'CipsSquad' => ['Cips/Squad/Resource/**/*.{storyboard,xcassets,xib}']
        }
        squad.private_header_files = ['Cips/Squad/Internal/*.h','Cips/Squad/Views/*.h']
    end

    s.subspec 'Qnock' do |qnock|
        qnock.dependency	'Cips/Core'
        qnock.source_files = 'Cips/Qnock/**/*'
    end
end
