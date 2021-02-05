//
//  GridViewController.swift
//  OpenMarket
//
//  Created by iluxsm on 2021/01/30.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    func registerXib() {
        let xib: UINib = UINib(nibName: "GridViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "itemGridCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        registerXib()
    }
}

extension GridViewController: UICollectionViewDelegate {

}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemGridCell", for: indexPath) as? GridViewCell else { return UICollectionViewCell() }
        return cell
    }
}
