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
        print("날씨 할라다가 귀찮아서 Git으로 변경")
        let vc = WeatherViewController(nibName: "WeatherViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

