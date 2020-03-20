//
//  ScreenFrameExtension.swift
//  HHYPageView
//
//  Created by 华惠友 on 2020/3/18.
//  Copyright © 2020 huayoyu. All rights reserved.
//

import UIKit

//刘海屏额外的高度

let heightOfAddtionalHeader: CGFloat = {
    if UIDevice.current.isiPhoneXorLater(){
        return 24.0
    } else {
        return 0.0
    }
}()

//底部非安全区域高度
let heightOfAddtionalFooter : CGFloat = {
    if UIDevice.current.isiPhoneXorLater(){
        return 34.0
    } else {
        return 0.0
    }
}()


extension UIDevice{
    //判断设备是不是iPhoneX以及以上
    public func isiPhoneXorLater() -> Bool {
        let screenHieght = UIScreen.main.nativeBounds.size.height
        if screenHieght == 2436 || screenHieght == 1792 || screenHieght == 2688 || screenHieght == 1624{
            return true
        }
        return false
    }
}


