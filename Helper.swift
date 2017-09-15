//
//  Helper.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/12/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Helper {
    
    
    
    static func createNavigationBar(viewContoller: UIViewController, title: String, barColor: UIColor, tabBarTitle: String) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: viewContoller)
        nav.tabBarItem.title = tabBarTitle
        nav.navigationBar.topItem?.title = title
        nav.navigationBar.barTintColor = barColor
        
        return nav
    }
}




