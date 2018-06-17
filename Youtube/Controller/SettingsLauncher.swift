//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Noshaid Ali on 10/6/17.
//  Copyright © 2017 Cricingif. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    let name:SettingName
    let imageName:String
    
    init(name:SettingName, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms and privacy policy"
    case Sendfeedback = "Send feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight:CGFloat = 50
    var homeContoller: HomeController?
    
    let settings: [Setting] = {
        return [Setting(name: .Settings, imageName:"settings"), Setting(name: .TermsPrivacy, imageName:"privacy"), Setting(name: .Sendfeedback, imageName:"feedback"), Setting(name: .Help, imageName:"help"), Setting(name: .SwitchAccount, imageName:"switch_account"), Setting(name: .Cancel, imageName:"cancel")]
    }()
    
    override init() {
        super.init()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: self.cellId)
    }
    
    func showSettings() {
        //show menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height:CGFloat = CGFloat(self.settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect.init(x:0, y:window.frame.height, width:window.frame.width, height:height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect.init(x:0, y:y, width:self.collectionView.frame.width, height:height)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss(setting: Setting, isGo:Bool = false) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect.init(x:0, y:window.frame.height, width:self.collectionView.frame.width, height:self.collectionView.frame.height)
            }
            
        }, completion: { (finish: Bool) in
            if isGo {
                if setting.name != .Cancel {
                    self.homeContoller?.showControllerForSetting(setting: setting)
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! SettingCell
        
        let setting = self.settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]
        self.handleDismiss(setting: setting, isGo: true)
    }
}

