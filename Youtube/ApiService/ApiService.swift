//
//  ApiService.swift
//  Youtube
//
//  Created by Noshaid Ali on 10/26/17.
//  Copyright © 2017 Cricingif. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrl(urlString: "\(baseUrl)/home.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrl(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrl(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrl(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            do {
                if let unWrapperData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unWrapperData, options: .mutableContainers) as? [[String:AnyObject]] {
                    /*var videos = [Video]()
                    for dictionary in jsonDictionaries {
                        let video = Video(dictionary: dictionary)
                        videos.append(video)
                    }*/
                    let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                    DispatchQueue.main.async(execute: {
                        completion(videos)
                    })
                }
            } catch let jsonError {
                print("_____",jsonError)
            }
        })
        task.resume()
    }
    
}
