#
# Be sure to run `pod lib lint UKPDFReader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UKPDFReader'
  s.version          = '0.1.0'
  s.summary          = 'UKPDFReader is a simple framework for reading PDF in iOS(>=11.0)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'UKPDFReader is a simple framework for reading PDF in iOS(>=11.0). The three features provided: Paging, Outline, and Thumbnails. All feature are easyly configurable.'

  s.homepage         = 'https://github.com/umakanta/UKPDFReader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Umakanta Sahoo' => 'umakanta1987@gmail.com' }
  s.source           = { :git => 'https://github.com/umakanta/UKPDFReader.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/umakanta_s'

  s.swift_version = '5.0'
  #s.platform      = :ios, '11.0'
  s.ios.deployment_target = '11.0'
  #s.source_files = 'UKPDFReader/Classes/**/*'
  s.source_files = ['*.swift']
  
  s.frameworks = 'UIKit', 'PDFKit'
  # s.resource_bundles = {
  #   'UKPDFReader' => ['UKPDFReader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
