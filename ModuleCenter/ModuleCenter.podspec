

Pod::Spec.new do |spec|

  spec.name         = "ModuleCenter"
  spec.version      = "1.0"
  spec.summary      = "模块"
  spec.description  = "模块"
  spec.homepage     = "https://github.com/7General/ModuleBoxiOS.git"
  spec.license      = "private"
  spec.author       = { "wangHZ" => "wanghuizhou21@163.com" }
  spec.source       = { :git => ".", :tag => "#{spec.version}" }
  spec.source_files = "Classes", "Classes/**/*.{h,m}"
  spec.platform     = :ios,'8.0'
  spec.pod_target_xcconfig = {'USE_HEADERMAP' => false}

end
