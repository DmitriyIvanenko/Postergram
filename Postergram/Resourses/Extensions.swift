//
//  Extensions.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 01.12.2022.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var bottom: CGFloat {
        return frame.size.width
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
}
