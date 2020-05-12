

Pod::Spec.new do |spec|

  spec.name         = "ModuleCommonUI"
  spec.version      = "1.0"
  spec.author           = "ZZG"
  spec.summary      = "ModuleCommonUI"
  spec.description  = "ModuleCommonUI-base基类信息等"
  spec.homepage     = "https://github.com/7General/ModuleBoxiOS.git"
  spec.license      = "private"
  spec.author       = { "wangHZ" => "wanghuizhou21@163.com" }
  spec.source       = { :git => ".", :tag => "#{spec.version}" }
  spec.source_files = "Classes", "Classes/**/*.{h,m}"
  spec.public_header_files = "ModuleCommonUI/**/*.h"
  spec.platform     = :ios,'8.0'
  spec.pod_target_xcconfig = {'USE_HEADERMAP' => false}
  
  spec.framework    = "UIKit"
  spec.dependency    'ModuleUIStack'

end
