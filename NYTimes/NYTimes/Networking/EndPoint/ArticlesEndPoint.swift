//
//  ArticlesEndPoint.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case development
    case qa
    case staging
    case production
}

public enum ArticleApi {
    case fetchArticles
}

extension ArticleApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .development: return "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json"
        case .qa: return ""
        case .staging: return ""
        case .production: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url.standardized
    }
    var path: String {
        switch self {
        case .fetchArticles:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {

        case .fetchArticles:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api-key": NetworkManager.ArticleAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
