//
//  GithubRepoViewController.swift
//  MVVMSample
//
//  Created by hanwe on 2021/02/05.
//

import UIKit
import RxSwift
import RxCocoa

class GithubRepoViewController: UIViewController {

    //MARK: Interface Builder
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: property
    var viewModel: GithubRepoViewModel = GithubRepoViewModel()
    var disposeBag: DisposeBag = DisposeBag()
    
    
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initBind()
        initSubscribe()
        viewModel.initSubscribe()
    }
    
    
    //MARK: function
    
    func initUI() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "GithubRepoTableViewCell", bundle: nil), forCellReuseIdentifier: "GithubRepoTableViewCell")
        self.indicator.isHidden = true
    }
    
    func initBind() {
        searchBar.rx.text
            .orEmpty
            .bind(to: self.viewModel.searchTextRelay)
            .disposed(by: self.disposeBag)
    }
    
    func initSubscribe() {
        viewModel.gitHubRepositories
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items) { tableView, row, githubRepository in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "GithubRepoTableViewCell")
                cell.textLabel?.text = "\(githubRepository.fullName)"
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.detailTextLabel?.text = "\(githubRepository.description)"
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                if $0 {
                    self.indicator.isHidden = false
                    self.indicator.startAnimating()
                }
                else {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    //MARK: action
}

//extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
//        
//        return cell
//    }
//    
//    
//}
