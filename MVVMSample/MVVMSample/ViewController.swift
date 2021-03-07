//
//  ViewController.swift
//  MVVMSample
//
//  Created by hanwe on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func startTestAction(_ sender: Any) {
        let vc = GithubRepoViewController(nibName: "GithubRepoViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

