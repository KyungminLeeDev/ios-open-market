//
//  ListViewController.swift
//  OpenMarket
//
//  Created by iluxsm on 2021/01/30.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - IBOutlets & Properties
    @IBOutlet weak var tableView: UITableView!
    var marketPage: MarketPage?
    var itemCount: Int?

    // MARK: - IBActions & Methods
    func registerXib() {
        let xib: UINib = UINib(nibName: "ListViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "itemListCell")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        registerXib()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        OpenMarketAPIClient().getMarketPage(pageNumber: 1) { result in
            switch result {
            case .success(let marketPage):
                self.marketPage = marketPage
                self.itemCount = marketPage.marketItems.count
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

// MARK: - Table view extensions
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 70 보다 값이 낮으면 답답해 보일 수 있습니다.
        return 70
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let marketPage = self.marketPage {
            return marketPage.marketItems.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemListCell") as? ListViewCell else {
            return UITableViewCell()
        }
        guard let marketPage = self.marketPage else {
            print("not loaded MarketPage")
            return UITableViewCell()
        }
        let item = marketPage.marketItems[indexPath.row]
        cell.itemName.text = item.title
        cell.itemStock.text = "\(item.stock ?? -1)"
        cell.itemPrice.text = item.priceWithCurrency
        if let discountedPrice = item.discountedPrice {
            cell.discountedItemPrice.text = "\(discountedPrice)"
        } else {
            cell.discountedItemPrice.text = ""
        }
        cell.itemImage.image = nil // 이미지 초기화
        
        DispatchQueue.global().async {
            
            guard let thumbnail = item.thumbnails?.first, let thumbnailURL = URL(string: thumbnail) else {
                return
            }
            guard let thumbnailData = try? Data(contentsOf: thumbnailURL) else {
                return
            }
            
            DispatchQueue.main.async {
                if let cellIndexPath = tableView.indexPath(for: cell) {
                    if cellIndexPath.row == indexPath.row {
                        cell.itemImage.image = UIImage(data: thumbnailData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        return cell
    }
}
