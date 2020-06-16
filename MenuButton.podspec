Pod::Spec.new do |s|
  s.name             = 'MenuButton'
  s.version          = '1.0.4'
  s.summary          = 'Animated button'
  s.description      = 'Animated button which looks like material design'
  s.homepage         = 'https://github.com/zfort/menubutton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrii Starostenko' => 'starostenko@zfort.com' }
  s.source           = { :git => 'https://github.com/zfort/menubutton.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'MenuButton/**/*.{swift}'
  s.resources = [
  	'MenuButton/Source/Private/UserInterface/MenuOwnerView/*.{xib}',
  	'MenuButton/Source/Private/UserInterface/MenuOwnerViewCell/*.{xib}'
  ]
end
