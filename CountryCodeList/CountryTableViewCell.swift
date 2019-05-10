//
//  CountryTableViewCell.swift
//  CountryCodeList
//
//  Created by jianwen ning on 03/05/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//  显示国家信息（国家名+缩写+手机区号）

import UIKit

let itemWidth:CGFloat = UIScreen.main.bounds.size.width / 3.0
let itemHeight:CGFloat = 40

class CountryTableViewCell: UITableViewCell {
    
    //显示国家名
    private lazy var countryName:UILabel = {
        var label = UILabel.init(frame: CGRect(x:0, y:5, width:itemWidth * 2, height:itemHeight))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    //显示国家名缩写
    private lazy var abbreviation:UILabel = {
        var label = UILabel.init(frame: CGRect(x:itemWidth * 2, y:5, width:itemWidth/2, height:itemHeight))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
//        label.textAlignment = NSTextAlignment.center
        return label
    }()
    //手机区号
    private lazy var phoneCode:UILabel = {
        var label = UILabel.init(frame: CGRect(x:itemWidth * 2 + itemWidth/2, y:5, width:itemWidth/2, height:itemHeight))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
//        label.textAlignment = NSTextAlignment.right
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    func setupUI(){
        self.contentView.addSubview(self.countryName)
        self.contentView.addSubview(self.abbreviation)
        self.contentView.addSubview(self.phoneCode)
    }
    
    var countryInfoModel:CountryItemModel?{
        didSet{
            guard let itemModel = countryInfoModel else {
                return
            }
            self.countryName.text = itemModel.countryName
            self.abbreviation.text = itemModel.countryCode
            self.phoneCode.text = itemModel.phoneCode
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
