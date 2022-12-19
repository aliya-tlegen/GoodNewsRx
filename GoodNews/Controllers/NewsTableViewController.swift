//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Mohammad Azam on 3/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private var articles = [Article]()
    private let disposeBag = DisposeBag()
    
    private let jsonDecoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "Good News"
        populateNews()
    }
    
    private func populateNews() {
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e228b07f881a43358896e3b3f0796cb7")!
//
//        let resource = Resource<ArticleList>(url: url)
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
//        Observable.just(url)
//            .flatMap { url -> Observable<Data> in
//                let request = URLRequest(url: url)
//                return URLSession.shared.rx.data(request: request)
//            }.map { data -> [Article]? in
//                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
//            }.subscribe(onNext: { [weak self] articles in
//                if let articles = articles {
//                    self?.articles = articles
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                }
//            }).disposed(by: disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description
        return cell
    }
    
}
