Pod::Spec.new do |spec|

  spec.name          = "RelevantBox"
  spec.version       = "2.5.1"
  spec.swift_version = "4.2"
  spec.summary       = "RelevantBox Marketing Robot IOS SDK"
  spec.description   = "RelevantBox Marketing Robot IOS SDK"
  spec.platform      = :ios, '8.0'
  spec.ios.deployment_target = "10.0"
  spec.homepage      = "https://github.com/xennio/harray-ios-sdk"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "RelevantBox Development Team" => "admin@relevantbox.io" }
  spec.source        = { :git => "https://github.com/xennio/harray-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "harray-ios-sdk/**/*.{h,m,swift}"
end
