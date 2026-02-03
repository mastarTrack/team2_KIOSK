//
//  ViewController.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/3/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let myView = MenuSectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
    }
    
    func configure() {
        view.addSubview(myView)
        
        myView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.leading.equalToSuperview()
        }
    }
}

