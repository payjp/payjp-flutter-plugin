#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
require 'json'

payjp_sdk = JSON.parse(File.read(File.join(__dir__, '../sdkconfig.json')))

Pod::Spec.new do |s|
  s.name             = 'payjp_flutter'
  s.version          = '0.7.2'
  s.summary          = 'A Flutter plugin for PAY.JP Mobile SDK.'
  s.description      = <<-DESC
A Flutter plugin for PAY.JP Mobile SDK.
                       DESC
  s.homepage         = 'https://github.com/payjp/payjp-flutter-plugin'
  s.license          = { :type => 'MIT' }
  s.author           = { 'PAY.JP (https://pay.jp)' => 'support@pay.jp' }
  s.swift_version    = '5.0'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.dependency 'PAYJPFlutterCore', "~> #{payjp_sdk['ios']}"
  # NOTE: If you need to scan card in your card form, please add the following dependency to your Podfile directly.
  # as default, we don't include this dependency because it causes a issue in arm64 simulator build.
  # s.dependency 'CardIO', '~> 5.4.1'7.2'
  s.dependency 'GoogleUtilities/AppDelegateSwizzler', '~> 8'
  s.dependency 'Flutter'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  s.ios.deployment_target = '10.0'
end

