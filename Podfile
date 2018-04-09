# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

project 'SwiftSample.xcodeproj'

def shared_pods
  # Pods for all schems
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
  pod 'ReSwift', '~> 4.0'
  pod 'RxSwift', '~> 4.1'
  pod 'Fabric', '~> 1.7.2'
  pod 'Crashlytics', '~> 3.9.3'
  pod 'SwiftyGif', '~> 4.1'
  pod 'YLProgressBar', '~> 3.10'
  pod 'Alamofire', '~> 4.5'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'SVProgressHUD', '~> 2.2'
end

target 'SwiftSample' do
  # Pods for SwiftSample scheme
    shared_pods
end

target 'SwiftSampleUITests' do
  # Pods for SwiftSampleUITests scheme
    shared_pods
end
