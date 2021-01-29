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

    // MARK: - IBActions & Methods
    func registerXib() {
        let xib: UINib = UINib(nibName: "ListViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "itemCell")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        registerXib()
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
        // 데이터를 받아오기 전 임시적인 값입니다.
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListViewCell else { return UITableViewCell() }
        return cell
    }
}
