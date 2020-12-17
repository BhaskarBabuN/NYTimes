//
//  ArticleListViewModel.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation

class ArticleListViewModel {
    
    var networkManager: NetworkManager = NetworkManager()
    var articles: [Article] = [Article]()
    
    var articlesCount: Int {
        return articles.count
    }
    
    func article(_ index: Int) -> Article {
        return self.articles[index]
    }
    
    func getPopularArticles(completion: @escaping (_ message: [String: Any]?, _ success: Bool, _ error: Error?) -> ()) {
        networkManager.getArticles() { [weak self] (articles, error) in
            guard let articles = articles else {
                completion([:], false, error as? Error)
                return
            }
            self?.articles = articles
            print(articles)
            completion([:], true, nil)
        }
    }
}
