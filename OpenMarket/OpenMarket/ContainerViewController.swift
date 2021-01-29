//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ContainerViewController: UIViewController {

    // MARK: - IBOutlets & Properties
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var gridView: UIView!
    var views: [UIView]!

    // MARK: - IBActions & Methods

    @IBAction func switchViewType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // listView
            viewContainer.bringSubviewToFront(listView)
        case 1: // gridView
            viewContainer.bringSubviewToFront(gridView)
        default:
            break
        }
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewContainer.bringSubviewToFront(listView)
    }
}

