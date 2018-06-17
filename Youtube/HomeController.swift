//
//  ViewController.swift
//  Youtube
//
//  Created by Noshaid Ali on 10/1/17.
//  Copyright © 2017 Cricingif. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let titles = ["Home","Trending","Subscriptions","Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        self.setupCollectionView()
        self.setupMenuBar()
        self.setupNavBarButtons()
    }
    
    func setupCollectionView() {
        //second way to scroll horizontally
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        self.collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        //self.collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //top margin
        self.collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //top margin of vertical scroll indicator
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        //one page like effect
        self.collectionView?.isPagingEnabled = true
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        self.navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }

    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeContoller = self
        return launcher
    }()
    
    func handleMore() {
        //show menu
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.navigationItem.title = setting.name.rawValue //rawValue used bcz we get string direct from enum
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        self.navigationController?.hidesBarsOnSwipe = true //hide nav bar no scroll up and show on down
        
        //on scroll up when nav bar is about to hide back view appears for some time (solution)
        let redView = UIView()
        self.view.addSubview(redView)
        redView.backgroundColor = UIColor.rgb(red: 230, green: 30, blue: 31)
        self.view.addConstraintsWith(format: "H:|[v0]|", views: redView)
        self.view.addConstraintsWith(format: "V:[v0(50)]", views: redView)
        
        self.view.addSubview(self.menuBar)
        self.view.addConstraintsWith(format: "H:|[v0]|", views: self.menuBar)
        self.view.addConstraintsWith(format: "V:[v0(50)]", views: self.menuBar)
        
        //on scroll up menu bar half hidden solution
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[Int(index)])"
        }
    }
    
    //MARK: - Scroll view methods
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //move menu uderline bar with scroll as animating effect
        self.menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //on swipe highlight menu icons
        let index = targetContentOffset.pointee.x / self.view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        self.menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))
    }
    
    //MARK: - Collection View delegate and datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let id: String
        if indexPath.item == 1 {
            id = trendingCellId
        } else if indexPath.item == 2 {
            id = subscriptionCellId
        } else {
            id = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: self.view.frame.width, height: self.view.frame.height-50)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}










