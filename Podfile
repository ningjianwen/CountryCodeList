platform:ios,'10.0'
inhibit_all_warnings!
use_frameworks!

def pods
    pod 'HandyJSON', '~> 5.0.0-beta'

end

target 'CountryCodeList' do
    pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
