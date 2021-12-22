Pod::Spec.new do |spec|

  spec.name = 'AppComponents'
  spec.version = '0.1.3'
  spec.summary = 'Components to be used in the App.'
  spec.homepage = 'https://github.com/Joao-LDS/AppComponents'
  spec.author = { 'João Luis dos Santos' => "joao_l_d_s@hotmail.com" }
  spec.license = { :type => 'private' }
  spec.source = { :git => 'https://github.com/Joao-LDS/AppComponents.git',
                  :tag => spec.version.to_s }

  spec.ios.deployment_target = '11.0'
  spec.requires_arc = true

  spec.cocoapods_version = '>= 1.5'
  spec.swift_version = '5.0'

  spec.source_files = 'AppComponents/**/*.{h,m,swift}'

  spec.resource_bundles = {
    'AppComponents' => [
      'AppComponents/**/*.xcassets',
      'AppComponents/**/*.xib'
    ]
  }

  spec.dependency 'UIView+Shimmer'

end
