Pod::Spec.new do |s|

  s.name         = "ZQTableChart"
  s.version      = "0.0.1"
  s.summary      = "一个简单的表格"

  s.description  = <<-DESC
                   一个简单的表格.
                   DESC

  s.homepage     = "https://github.com/zhaozzq/ZQTableChart"
  # s.screenshots  = "https://github.com/zhaozzq/ZQTableChart/blob/master/screen01.jpeg"

  s.license      = "MIT"
  s.author             = { "Zhao" => "zhao_zzq2012@163.com" }
  # s.social_media_url   = "http://twitter.com/Zhao"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/zhaozzq/ZQTableChart.git", :tag => "0.0.1" }

  s.source_files  = "ZQTableChart/*"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
