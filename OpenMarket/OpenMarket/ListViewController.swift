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
    private var pageData: MarketPage?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        registerXib()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDataNotification(_:)), name: .DidReceiveDataNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Extensions
// MARK: Methods
extension ListViewController {
    private func registerXib() {
        let xib: UINib = UINib(nibName: "ListViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "itemListCell")
    }

    @objc func didReceiveDataNotification(_ noti: Notification) {
        guard let pageData: MarketPage = noti.userInfo?["pageData"] as? MarketPage else { return }
        self.pageData = pageData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func attributedString() {

    }
}

// MARK: Table view extensions
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 70 보다 값이 낮으면 답답해 보일 수 있습니다.
        return 70
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터를 받아오기 전 임시적인 값입니다.
        guard let listCount: Int = pageData?.marketItems.count else { return 0 }
        return listCount
    }

    //TODO: Decrease depth & separate roles
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemListCell") else {
            return UITableViewCell()
        }
        guard let listCell: ListViewCell = cell as? ListViewCell else { return cell }
        guard let items = self.pageData?.marketItems else { return listCell }

        listCell.itemName.text = items[indexPath.row].title

        if items[indexPath.row].discountedPrice == nil { // 할인 적용이 안되는 상품이라면,
            listCell.itemPrice.text = items[indexPath.row].priceWithCurrency
            listCell.discountedItemPrice.isHidden = true
        } else { // 할인 적용 상품이라면
            let attributes: [NSAttributedString.Key: Any] = [.strikethroughStyle: 1, .foregroundColor: UIColor.red]
            let attributedString: NSAttributedString = NSAttributedString(string: listCell.itemPrice.text!, attributes: attributes)
            listCell.itemPrice.attributedText = attributedString
            listCell.itemPrice.text = items[indexPath.row].priceWithCurrency // AttributedString 적용
            listCell.discountedItemPrice.isHidden = false
        }
        listCell.discountedItemPrice.text = items[indexPath.row].discountedPriceWithCurrency

        guard let itemStock: Int = items[indexPath.row].stock else { return listCell }
        let attributesForStock: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemYellow]
        let attributedStockString: NSAttributedString = NSAttributedString(string: listCell.itemStock.text!, attributes: attributesForStock)
        if itemStock == 0 {
            listCell.itemStock.attributedText = attributedStockString
            listCell.itemStock.text = "품절"
        } else {
            listCell.itemStock.text = String(itemStock)
        }

        return listCell
    }
}
