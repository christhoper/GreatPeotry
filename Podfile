source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

workspace 'GreatPeotry'

use_frameworks!
#关闭CocoaPods中的警告
inhibit_all_warnings!


def pods_common
  pod 'RxSwift'
  pod 'SnapKit'
  pod 'RxCocoa'
  pod 'HandyJSON'
  pod 'Kingfisher'
  pod "KRProgressHUD"
end

def pods_router
  pod 'CTMediator', '~> 25'
end



target 'GreatPeotry' do

  project './GreatPeotry.xcodeproj'
  pods_common
  pods_router

end


target 'Mine' do

  project './Mine/Mine.xcodeproj'
  pods_common
  pods_router

end

target 'Home' do

  project './Home/Home.xcodeproj'
  pods_common
  pods_router

end


target 'Creation' do

  project './Creation/Creation.xcodeproj'
  pods_common
  pods_router

end

target 'Router' do

  project './Router/Router.xcodeproj'
  pods_common
  pods_router

end


target 'GPFoundation' do

  project './GPFoundation/GPFoundation.xcodeproj'
  pods_common
  pods_router

end

