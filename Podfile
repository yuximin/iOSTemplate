# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'

target 'iOSTemplate' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSTemplate
  pod 'SnapKit', '~> 5.6.0'
  pod 'FSPagerView'
  pod 'Tiercel'
  pod 'libpag'
  pod 'RongCloudIM/IMKit', '~> 5.2.5'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'AFNetworking', '~> 4.0'
  pod 'LookinServer', :configurations => ['Debug']
  pod 'SVGAPlayer', '~>2.3'
#  pod 'Moya', '~> 15.0'
  pod 'Moya/RxSwift', '~> 15.0'
  pod 'XDownloader', :path => 'Frameworks/XDownloader'
  pod 'SDWebImage'
  pod 'Kingfisher'
  pod 'MINDownloader', :source => 'git@github.com:yuximin/Specs.git'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
