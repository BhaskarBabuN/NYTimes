//
//  ArticleList.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation

struct ArticleListResponse {
    let articles: [Article]
    let totalResults: Int
    let copyright: String
    let status: String
}

extension ArticleListResponse: Decodable {
    
    private enum ArticleListResponseCodingKeys: String, CodingKey {
        case articles = "results"
        case totalResults = "num_results"
        case copyright
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleListResponseCodingKeys.self)
        articles = try container.decode([Article].self, forKey: .articles)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        copyright = try container.decode(String.self, forKey: .copyright)
        status = try container.decode(String.self, forKey: .status)
    }
}


struct Article {
    
    let title: String
    let publishedDate: String
    let articleBy: String
    let media: [Media]
    let source: String
    let keywords: String, abstract: String
}

extension Article: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_date"
        case articleBy = "byline"
        case media = "media"
        case source
        case keywords = "adx_keywords"
        case abstract
    }

    init(from decoder: Decoder) throws {
        let articleContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        title = try articleContainer.decode(String.self, forKey: .title)
        publishedDate = try articleContainer.decode(String.self, forKey: .publishedDate)
        articleBy = try articleContainer.decode(String.self, forKey: .articleBy)
        source = try articleContainer.decode(String.self, forKey: .source)
        media = try articleContainer.decode([Media].self, forKey: .media)
        keywords = try articleContainer.decode(String.self, forKey: .keywords)
        abstract = try articleContainer.decode(String.self, forKey: .abstract)
    }
}

struct Media {
    let copyright: String
    let metaData: [MediaMetaData]
}

extension Media: Decodable {
    private enum MediaCodingKeys: String, CodingKey {
        case copyright
        case metaData = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MediaCodingKeys.self)
        copyright = try container.decode(String.self, forKey: .copyright)
        metaData = try container.decode([MediaMetaData].self, forKey: .metaData)
    }
}
struct MediaMetaData {
    let url: String
    let format: String
}

extension MediaMetaData: Decodable {
    private enum MediaMetaDataDetails: String, CodingKey {
        case url
        case format
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MediaMetaDataDetails.self)
        url = try container.decode(String.self, forKey: .url)
        format = try container.decode(String.self, forKey: .format)
    }
}

