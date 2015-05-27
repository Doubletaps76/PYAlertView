Pod::Spec.new do |s|
  s.name         = 'PYAlertView'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE'}
  s.homepage     = 'https://github.com/Doubletaps76/PYAlertView'
  s.authors      = { 'Tsau,Po-Yuan' => 'heineken00000@gmail.com' }
  s.summary      = 'An easy-to-use Custom AlertView with POP animation !'
  s.source       = { :git => 'https://github.com/Doubletaps76/PYAlertView.git', 
  					 :tag => s.version.to_s }
  s.source_files = 'PYAlertView/**/*.{h,m}'
  s.platform = :ios, '7.1'
  s.ios.deployment_target = '7.1'
  s.requires_arc = true
end