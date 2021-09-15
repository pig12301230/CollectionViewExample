//
//  ViewController.swift
//  example
//
//  Created by 莊英祺 on 2021/4/8.
//

import UIKit

struct TestData {
    let first: String
    let second: String
    let third: String
    let forth: String
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let refresher = UIRefreshControl()

    var data: [TestData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        data = randomData()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
//        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "TestCell")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = layout
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    @objc func loadData() {
        refresher.beginRefreshing()
        data = randomData()
//        self.collectionView.reloadData()
//        self.collectionView.reloadSections(IndexSet(integer: 1))
        self.collectionView.performBatchUpdates({ [weak self] in

            self?.collectionView.reloadSections(IndexSet.init(integer: 0))
                self?.collectionView.layoutIfNeeded()

            }) { (_) in
                print("success")
            }
        refresher.endRefreshing()
    }
    
    
    private func randomData() -> [TestData] {
        var datas: [TestData] = []
        var dict: [Int: String] = [1: "first",
                                   2: "secondsecondsecondsecondsecondsecondsecond",
                                   3: "thirdthirdthirddddd",
                                   4:"fortforthforthforthforthforthforthforthforthforthforthforthforthforthforthforthforthforthforthforth "
        
        ]
        let random = Int.random(in: 1...10)
        for i in 1...random {
            var a = Int.random(in: 1...4)
            var b = Int.random(in: 1...4)
            var c = Int.random(in: 1...4)
            var d = Int.random(in: 1...4)
            let data = TestData(first: dict[a]!, second: dict[b]!, third: dict[c]!, forth: dict[d]!)
            datas.append(data)
        }
        
        return datas
    }
}

class TestCell: UICollectionViewCell {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var forthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func bind(data: TestData) {
        self.firstLabel.text = data.first
        self.secondLabel.text = data.second
        self.thirdLabel.text = data.third
        self.forthLabel.text = data.forth
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        
        cell.bind(data: data[indexPath.item])
        return cell
    }
}
