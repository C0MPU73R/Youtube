//
//  TrendingCell.swift
//  Youtube
//
//  Created by Noshaid Ali on 6/12/18.
//  Copyright © 2018 Cricingif. All rights reserved.
//

import Foundation

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
