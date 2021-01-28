//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var viewContainer: UIView!
    var views: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        views = [UIView]()
        views.append(ListViewController().view)
        views.append(GridViewController().view)

        for v in views {
            viewContainer.addSubview(v)
        }
        viewContainer.bringSubviewToFront(views[0])
    }

    @IBAction func switchViewType(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
}

