//
//  GithubRepoService.swift
//  MVVMSample
//
//  Created by hanwe on 2021/03/03.
//

import UIKit
import SwiftyJSON
import Alamofire
import RxSwift

class GithubRepoService { // MVVM에서는 이걸 모델이라 부르나?;; 서비스라고 쓰는사람이 있고 모델이라고 쓰는사람이 있는듯..
    
    var disposeBag: DisposeBag = DisposeBag()
    
    @discardableResult func getGitRepos(text: String, page: Int) -> Observable<[RepoModel]> {
        return Observable<[RepoModel]>.create { emmitter in
            DataApiManager.requestGETURLRx("https://api.github.com/search/repositories?q=\(text)&sort=start&page=\(page)", headers: nil)
                .subscribe(onNext: { response in
                    var repoModelArr: [RepoModel] = []
                    for i in 0..<response["items"].count {
                        if let model: RepoModel = RepoModel.fromJson(jsonData: response["items"][i].rawString()?.data(using: .utf8), object: RepoModel()) {
                            repoModelArr.append(model)
                        }
                    }
                    emmitter.onNext(repoModelArr)
                    emmitter.onCompleted()
                }, onError: { err in
                    emmitter.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
        
    }
}
