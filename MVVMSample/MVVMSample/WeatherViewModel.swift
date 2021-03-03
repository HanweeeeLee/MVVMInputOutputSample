//
//  WeatherViewModel.swift
//  MVVMSample
//
//  Created by hanwe on 2021/02/05.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

protocol WeatherViewModelInput {
    var searchTextRelay: PublishRelay<String> { get }
}

protocol WeatherViewModelOutput {
    var navigationBarTitle: Observable<String> { get }
    var gitHubRepositories: PublishSubject<[RepoModel]> { get } // model
    var isLoading: PublishSubject<Bool> { get }
    var error: Observable<NSError> { get }
}

protocol WeatherViewModelType {
    var inputs: WeatherViewModelInput { get }
    var outputs: WeatherViewModelOutput { get }
}

class WeatherViewModel: WeatherViewModelInput, WeatherViewModelOutput {
    
    //MARK: WeatherViewModelInput property
    var searchTextRelay: PublishRelay<String> = .init()
    
    //MARK: WeatherViewModelOutput property
    var navigationBarTitle: Observable<String>
    var isLoading: PublishSubject<Bool>
    var error: Observable<NSError>
    var gitHubRepositories: PublishSubject<[RepoModel]>
    
    //MARK: property
    var disposeBag: DisposeBag = DisposeBag()
    var gitHubRepoService: GithubRepoService = GithubRepoService()
    
    //MARK: life cycle
    init() {
        self.navigationBarTitle = Observable.just("hi~ this is navigation bar title")
        self.isLoading = PublishSubject.init()
        self.error = Observable.just(NSError())
        self.gitHubRepositories = PublishSubject.init()
    }
    
    //MARK: func
    func initSubscribe() {
        self.searchTextRelay
            .debounce(.milliseconds(600), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .subscribe(onNext: { searchTxt in
                self.isLoading.onNext(true)
                self.gitHubRepoService.getGitRepos(text: searchTxt, page: 0)
                    .subscribe(onNext: { repoModelArr in
                        self.gitHubRepositories.onNext(repoModelArr)
                        self.isLoading.onNext(false)
                    }, onError: { err in
                        print("err:\(err)")
                        self.error = Observable.just(err as NSError)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: self.disposeBag)
    }

}
