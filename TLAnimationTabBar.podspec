
Pod::Spec.new do |s|
  s.name         = 'TLAnimationTabBar'
  s.version      = '1.0.2'
  s.license      = 'MIT'
  s.ios.deployment_target = '8.0'
  s.platform     = :ios, '8.0'
  s.summary      = 'Animation For TabBarItem'
  s.homepage     = 'https://github.com/LoongerTao/TLAnimationTabBar'
  s.author       = { 'LoongerTao' => '495285195@qq.com' }
  s.requires_arc = true
  s.source       = { :git => 'https://github.com/LoongerTao/TLAnimationTabBar.git', :tag => s.version }
  s.public_header_files = 'TLAnimationTabBar/TLAnimationTabBar.h'
  s.source_files = 'TLAnimationTabBar/TLAnimationTabBar.h'
end


# 错误：xcodebuild: Returned an unsuccessful exit code. 
# 一般是有头文件相互依赖，pod检测通不过


# [!] There was an error pushing a new version to trunk: execution expired
# 网络问题，更换网络

