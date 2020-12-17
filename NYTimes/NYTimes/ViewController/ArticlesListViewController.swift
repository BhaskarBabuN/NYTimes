//
//  ArticlesListViewController.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var activityIndicatorView: ActivityIndicatorView!
    
    let listViewModel: ArticleListViewModel = ArticleListViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NY Times Most Popular"
        registerCell()
        setupActivityIndicator()
        activityIndicatorView.startAnimating()
        fetchArticle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func registerCell() {
        articlesTableView.rowHeight = 130

        articlesTableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticlesTableViewCell")
    }
    
    func setupActivityIndicator() {
        self.activityIndicatorView = ActivityIndicatorView(title: "Fetching articles...", center: self.view.center)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
    }
    
    func fetchArticle() {
        self.errorLabel.isHidden = true
        listViewModel.getPopularArticles() { [weak self] (message, success, error)  in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.errorLabel.isHidden = success
                self?.articlesTableView.isHidden = !success
                if success {
                    self?.articlesTableView.reloadData()
                }
            }
        }
    }

}

extension ArticlesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.articlesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticlesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as? ArticlesTableViewCell ?? ArticlesTableViewCell()
        let article = listViewModel.article(indexPath.row)
        cell.configureCell(article: article)
        return cell
    }
}

extension ArticlesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = listViewModel.article(indexPath.row as Int)
        let detaiViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        detaiViewController.article = article
        self.navigationController?.pushViewController(detaiViewController, animated: false)
    }

}
