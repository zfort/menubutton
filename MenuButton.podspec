Pod::Spec.new do |s|
  s.name             = 'MenuButton'
  s.version          = '1.0.0'
  s.summary          = 'Animated button'
  s.description      = 'Animated button which looks like material design'
  s.homepage         = 'https://github.com/zfort/menubutton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zfort Group' => '' }
  s.source           = { :git => 'https://github.com/zfort/menubutton.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'
  s.source_files = 'MenuButton/*'
end