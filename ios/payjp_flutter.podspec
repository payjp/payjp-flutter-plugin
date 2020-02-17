#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'payjp_flutter'
  s.version          = '0.1.6'
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
  s.dependency 'PAYJP', '~> 1.1.5'
  s.dependency 'CardIO', '~> 5.4.1'
  s.dependency 'Flutter'

  s.ios.deployment_target = '9.0'
end

