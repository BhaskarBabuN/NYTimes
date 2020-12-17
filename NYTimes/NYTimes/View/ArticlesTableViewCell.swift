//
//  ArticlesTableViewCell.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = UIImage(named: "No_image_available")
    }
    
    func configureCell(article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.articleBy
        dateLabel.text = article.publishedDate
        typeLabel.text = article.source
        guard let url = article.media.first?.metaData.first?.url else {
            print("url not found")
            return
        }
        posterImageView.loadImageUsingCache(withUrl: url)
    }
}
