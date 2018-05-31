Pod::Spec.new do |s|
  s.name             = 'MenuButton'
  s.version          = '1.0.0'
  s.summary          = 'Animated button'
  s.description      = 'Animated button which looks like material design'
  s.homepage         = 'https://github.com/zfort/menubutton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zfort Group' => 'starostenko@zfort.com' }
  s.source           = { :git => 'https://github.com/zfort/menubutton.git', :branch => 'master' }
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'
  s.source_files = 'MenuButton/*'
end