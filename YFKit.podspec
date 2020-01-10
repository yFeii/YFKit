#
# Be sure to run `pod lib lint YFKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YFKit'
  s.version          = '0.7.6'
  s.summary          = 'A collection of iOS components.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yFeii/YFKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yFeii' => '1486662452@qq.com' }
  s.source           = { :git => 'https://github.com/yFeii/YFKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YFKit/Classes/**/*.{h,m}'
  s.resource = "YFKit/Classes/UI/PickerView/BRPickerView/AddressPickerView/BRPickerView.bundle"
  #s.resource_bundles = {
  #   'YFKit' => ['YFKit/Classes/UI/PickerView/BRPickerView/AddressPickerView/BRPickerView.bundle/BRCity.plist']
  #}

  # s.frameworks = 'UIKit', 'MapKit'
  # s.public_header_files = 'Pod/Classes/**/*.h'   #公开头文件地址

  s.public_header_files = 'YFKit/Classes/**/*.h'
  s.prefix_header_contents = '#import <Masonry/Masonry.h>','#import <Toast/UIView+Toast.h>','#import <YFKit/YFKit.h>'


  s.dependency 'Toast'
  s.dependency 'Masonry'
  s.dependency 'YTKNetwork'
  
end
