Pod::Spec.new do |s|
  s.name             = 'MenuButton'
  s.version          = '1.0.0'
  s.summary          = 'By far the most fantastic view I have seen in my entire life. No joke.'
  s.description      = ''
  s.homepage         = 'https://github.com/zfort/menubutton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zfort Group' => '' }
  s.source           = { :git => 'https://github.com/zfort/menubutton.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'MenuButton/Source/Public/MenuButtonView/MenuButtonView.swift', 'MenuButton/Source/Public/MenuItem/MenuItem.swift'
 
end