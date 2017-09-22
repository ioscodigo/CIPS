#
# Be sure to run `pod lib lint Chips.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Chips'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Chips.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fajaraw/Chips'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fajaraw' => 'fajar@codigo.id' }
  s.source           = { :git => 'https://github.com/fajaraw/Chips.git', :tag => s.version.to_s }
  s.requires_arc	 = true
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.xcconfig       = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/"' }

#s.source_files = 'Chips/Chips.h'
  
  # s.resource_bundles = {
  #   'Chips' => ['Chips/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking'

    s.subspec 'Core' do |core|
        core.source_files = 'Chips/Core/**/*'
    end

    s.subspec 'Squad' do |squad|
        squad.dependency	'Chips/Core'
        squad.source_files = 'Chips/Squad/**/*'
    end

    s.subspec 'Qnock' do |qnock|
        qnock.dependency	'Chips/Core'
        qnock.source_files = 'Chips/Qnock/**/*'
    end
end
