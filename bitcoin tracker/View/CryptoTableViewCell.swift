 //
 //  CryptoTableViewCell.swift
 //  bitcoin tracker
 //
 //  Created by Dalveer singh on 15/05/21.
 //
 
 import UIKit
 
class CryptoTableViewCellModel{
    let name:String
    let symbol:String
    let price:String
    let iconURL:URL?
    var iconData:Data?
    init(name:String,symbol:String,price:String,iconURL:URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.iconURL = iconURL
    }
 }
 
 class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        coinImage.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
    }
    func configure(with viewModel:CryptoTableViewCellModel){
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price 
        if let data = viewModel.iconData {
            coinImage.image = UIImage(data: data)
        }
        else if let url = viewModel.iconURL{
            
            let task = URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
                if let data = data {
                    viewModel.iconData = data
                    DispatchQueue.main.async {
                        self?.coinImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
 }
