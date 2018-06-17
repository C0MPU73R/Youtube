//
//  FeedCell.swift
//  Youtube
//
//  Created by Noshaid Ali on 5/18/18.
//  Copyright © 2018 Cricingif. All rights reserved.
//

import UIKit

//this represent one screen i.e 4 horizontal cells in collection view
class FeedCell: BaseCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor  = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    // '()' is used to execute this closure block
    //lazy is used here bcz we want to access 'self' inside this closure block
    
    var videos: [Video]?
    let cellId = "cellId"
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        addSubview(collectionView)
        addConstraintsWith(format: "H:|[v0]|", views: collectionView)
        addConstraintsWith(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}

extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = self.videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize.init(width: frame.width, height: height+16+88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = VideoLauncher()
        obj.showVideoPlayer()
    }
}













