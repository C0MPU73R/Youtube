//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Noshaid Ali on 6/12/18.
//  Copyright © 2018 Cricingif. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
