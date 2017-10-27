#
# Be sure to run `pod lib lint StyleGuide.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StyleGuide'
  s.version          = '0.1.0'
  s.summary          = 'The theming library for your amazing iOS app!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
StyleGuide makes it very easy to style your iOS app using just a JSON file.
The aim is to keep the app ui consistent, changeable from a single place and to cut the ui code.
                       DESC

  s.homepage         = 'https://github.com/shubham01/StyleGuide'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shubham01' => 'shubham.agr001@gmail.com' }
  s.source           = { :git => 'https://github.com/shubham01/StyleGuide.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'StyleGuide/Classes/**/*'
  
  # s.resource_bundles = {
  #   'StyleGuide' => ['StyleGuide/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
