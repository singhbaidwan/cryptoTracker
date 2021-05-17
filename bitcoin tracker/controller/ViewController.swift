//
//  ViewController.swift
//  bitcoin tracker
//
//  Created by Dalveer singh on 11/05/21.
//

import UIKit

class ViewController: UIViewController {
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(CryptoTableViewCell.self,forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    private var viewModels = [CryptoTableViewCellModel]()
    
    static let numberFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.allowsFloats = true
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        view.addSubview(tableView)
        let nib = UINib.init(nibName: "CryptoTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        APICaller.shared.getAllCryptoData { [weak self](result) in

            switch result{
            case .success(let models):
                print(models.count)
                self?.viewModels = models.compactMap({
                    let price = $0.price_usd ?? 0
                    let massetId = $0.asset_id
                    let formatter = ViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    let icon = APICaller.shared.icons.filter { (icon) -> Bool in
                        icon.asset_id == massetId
                    }.first?.url ?? ""
                    let iconURL = URL(string: icon)
                    return CryptoTableViewCellModel(name: $0.name ?? "N/A", symbol: $0.asset_id, price: priceString ?? "N/A",iconURL: iconURL)
                 })
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error is \(error)")
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

//MARK:- TableViewDataSource and delegate
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier,for: indexPath) as? CryptoTableViewCell
        else
        {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

