source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

# ignore all warnings from all pods
inhibit_all_warnings!
source 'http://mobile-sdk.jumio.com/distribution.git'

use_frameworks!

def statusbar_pods
    pod 'PhoneNumberKit'
end

target 'StatusBar' do
    statusbar_pods
end

target 'StatusBarTests' do
    statusbar_pods
end
