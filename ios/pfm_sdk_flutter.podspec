#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint pfm_sdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pfm_sdk_flutter'
  s.version          = '1.0.0'
  s.summary          = 'Flutter IOS SDK for Equal PFM'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://equal.in'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Equal Identity Pvt Ltd' => 'anil@equal.in' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'equal_sdk_flutter_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
