//
//  GPConstant.swift
//  GPFoundation
//
//  Created by bailun on 2020/6/24.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public struct GPConstant {
    /// 顶部安全区域偏移量
    public static var kSafeAreaTopInset: CGFloat {
        UIDevice.isFullScreen() ? 44 : 20
    }
    
    /// 底部安全区域偏移量
    public static var kSafeAreaBottomInset: CGFloat {
        UIDevice.isFullScreen() ? 34 : 0
    }
    
    public static var kNavigationBarHeight: CGFloat {
        UIDevice.isFullScreen() ? 88 : 64
    }
    
    public static var kTabBarHeight: CGFloat {
        UIDevice.isFullScreen() ? 49 + 34 : 49
    }
    
    public static var kToolBarHeight: CGFloat {
        20
    }
    
    public static var isFullScreen: Bool {
        UIDevice.isFullScreen()
    }
    
    public static var width: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    public static var height: CGFloat {
        UIScreen.main.bounds.height
    }
}
