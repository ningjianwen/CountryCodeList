//
//  SectionListModel.swift
//  CountryCodeList
//
//  Created by jianwen ning on 03/05/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//

import UIKit
import HandyJSON

struct SectionListModel: HandyJSON {
    var key: String? //分组可以
    var data: [CountryItemModel]? //分组list
}

struct CountryItemModel: HandyJSON {
   
   var index: Int = 0 //分组里面的索引
   var countryName: String? //国家名字
   var countryCode: String? //国家编码缩写
   var phoneCode: String? //手机号编码
}
