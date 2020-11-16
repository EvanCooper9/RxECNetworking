#
# Be sure to run `pod lib lint RxECNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxECNetworking'
  s.version          = '1.0.0'
  s.summary          = 'An extension of ECNetworking'
  s.description      = 'An extension of ECNetworking'
  s.homepage         = 'https://github.com/EvanCooper9/RxECNetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EvanCooper9' => 'evan.cooper@rogers.com' }
  s.source           = { :git => 'https://github.com/EvanCooper9/RxECNetworking.git', :tag => s.version.to_s }
  s.social_media_url = 'https://evancooper.tech'
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.3'
  s.source_files = 'Sources/**/*'
  s.dependency 'ECNetworking'
  s.dependency 'RxSwift'
end
