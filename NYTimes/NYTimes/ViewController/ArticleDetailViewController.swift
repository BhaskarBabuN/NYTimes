//
//  ArticleDetailViewController.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keywordsLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }
    
    func configView() {
        titleLabel.text = article?.title
        dateLabel.text = article?.publishedDate
        keywordsLabel.text = article?.keywords
        sourceLabel.text = article?.source
        byLabel.text = article?.articleBy
        abstractLabel.text = article?.abstract
        if let posterUrl = article?.media.last?.metaData.last?.url {
            posterImageView.loadImageUsingCache(withUrl: posterUrl)
        } else {
            posterImageView.image = UIImage(named: "No_image_available")
        }
    }
    
    deinit {
        print("Article detail view controller released")
    }
}
