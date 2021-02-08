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
    let client: OpenMarketAPIClient = OpenMarketAPIClient()
    var indexNumber: Int = 1

    // MARK: - IBActions
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
        self.requestItemsList(of: indexNumber)
    }
}

// MARK: - Extensions
// MARK: Types
extension Notification.Name {
    static let DidReceiveDataNotification: Notification.Name = Notification.Name(rawValue: "DidReceiveData")
}

// MARK: Methods
extension ContainerViewController {
    // 페이지 데이터 불러올건데, 별 다른 페이지 번호 요청 없으면 1페이지 보여줄거야.
    func requestItemsList(of page: Int) {
        self.client.getMarketPage(pageNumber: page) { result in
            switch result {
            case .success(let marketPage):
                NotificationCenter.default.post(name: .DidReceiveDataNotification, object: nil, userInfo: ["pageData": marketPage])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
