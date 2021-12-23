source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!

workspace 'AppComponents.xcworkspace'

target 'AppComponents' do
	
	pod 'UIView-Shimmer'

  target 'AppComponentsTests' do
		
		pod 'SnapshotTesting'
		
  end

end

target 'SandBox' do
	
	project 'SandBox/SandBox'
	
	pod 'AppComponents', :path => './'

end
