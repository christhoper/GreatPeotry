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
  pod 'R.swift'
  pod 'Localize-Swift'
  pod 'VerticalCardSwiper'
end

def pods_router
  pod 'CTMediator'
end

def pods_home
end

def pods_mine
  
end

def pods_creation
  
end



target 'GreatPeotry' do

  project './GreatPeotry.xcodeproj'
  pods_common
  pods_router
  pods_home
  pods_creation
  pods_mine
  
end


target 'Mine' do
  
  project './Mine/Mine.xcodeproj'
  pods_common
  pods_router
  pods_mine

end

target 'Home' do

  project './Home/Home.xcodeproj'
  pods_common
  pods_router
  pods_home

end


target 'Creation' do

  project './Creation/Creation.xcodeproj'
  pods_common
  pods_router
  pods_creation

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

