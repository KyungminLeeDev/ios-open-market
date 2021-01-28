//
//  ListViewController.swift
//  OpenMarket
//
//  Created by iluxsm on 2021/01/29.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let nib = UINib(nibName: "ListViewCell", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "itemCell")
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell") else {
            return UITableViewCell()
        }
        return cell
    }
}
