# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'KraftyDraftOfficial' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'XLPagerTabStrip'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'SideMenu'
  pod 'Firebase/Core'
  pod 'FirebaseUI/Auth'
  pod 'FirebaseUI/Email'
  pod 'FirebaseUI/Google'
  pod 'FirebaseUI/Facebook'
  pod 'FirebaseUI/OAuth'
  pod 'Firebase/Messaging'

  #pod 'FacebookSDK'
  #pod 'FacebookSDK/LoginKit'
  #pod 'FacebookSDK/ShareKit'
  #pod 'FacebookSDK/PlacesKit'
  #pod 'Bolts'
  #pod 'FBSDKCoreKit/Swift'
  #pod 'FBSDKLoginKit/Swift'
  #pod 'FBSDKShareKit'
  #pod 'FBSDKPlacesKit'
  #pod 'FBSDKMessengerShareKit'


  # Pods for KraftyDraftOfficial

  target 'KraftyDraftOfficialTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KraftyDraftOfficialUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
