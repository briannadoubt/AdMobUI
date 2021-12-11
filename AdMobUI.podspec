#
# Be sure to run `pod lib lint AdMobUI.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'AdMobUI'
  s.version          = '1.0.1'
  s.summary          = 'A simple SwiftUI wrapper for AdMob Banner Ads (in a cocoapod...).'

  s.description      = <<-DESC
AdMobUI simplifies the implementation of AdMob ads in your iOS app. See the readme on the github repo for more information.
                       DESC

  s.homepage         = 'https://github.com/briannadoubt/AdMobUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Brianna Doubt' => 'bri@briannadoubt.com' }
  s.source           = { :git => 'https://github.com/briannadoubt/AdMobUI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/briannadoubt'

  s.ios.deployment_target = '14.0'

  s.source_files = 'Sources/**/*'
  
  s.frameworks = 'SwiftUI'
  
  s.dependency 'Google-Mobile-Ads-SDK'
  
end
