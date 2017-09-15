//
//  MainTabBar.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/12/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setupView() {
                
        let recordController = RecordController(collectionViewLayout: UICollectionViewFlowLayout())
        let recordNavigationController = Helper.createNavigationBar(viewContoller: recordController, title: "Records", barColor: UIColor.red, tabBarTitle:
            "Records")
        recordNavigationController.tabBarItem.image = #imageLiteral(resourceName: "recordsSymbol5")
        recordNavigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        if #available(iOS 11.0, *) {
            recordNavigationController.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        
        let mapNavigationController = Helper.createNavigationBar(viewContoller: MapController(), title: "Map", barColor: UIColor.red, tabBarTitle: "Map")
        mapNavigationController.tabBarItem.image = #imageLiteral(resourceName: "locationSymbol")
        mapNavigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        
        let settingsNavigationController = Helper.createNavigationBar(viewContoller: SettingsController(), title: "Settings", barColor: UIColor.red, tabBarTitle: "Settings")
        settingsNavigationController.tabBarItem.image = #imageLiteral(resourceName: "if_settings_115801")
        settingsNavigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
        if #available(iOS 11.0, *) {
            settingsNavigationController.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        self.viewControllers = [recordNavigationController, mapNavigationController, settingsNavigationController]
        
        self.tabBar.tintColor = UIColor.red
    }
    
}
