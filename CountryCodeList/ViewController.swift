//
//  ViewController.swift
//  CountryCodeList
//
//  Created by jianwen ning on 03/05/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//

import UIKit
import HandyJSON

let cellIdentifier: String = "cellIdentifier"
let screenWidth: CGFloat = UIScreen.main.bounds.size.width
let screenHeight: CGFloat = UIScreen.main.bounds.size.height
let isIphoneX: Bool = Int(screenHeight/screenWidth * 100) == 216 ? true : false //判断是否是iphoneX系列
let navbarHeight:CGFloat = isIphoneX ? 88.0 : 64.0 //导航栏的高度

class ViewController: UIViewController {

    private lazy var tableview: UITableView = {
        
//        let tableview = UITableView.init(frame: CGRect(x:0, y:navbarHeight, width: screenWidth, height: screenHeight - navbarHeight), style: UITableView.Style.plain)
        let tableview = UITableView.init(frame: self.view.frame, style: UITableView.Style.plain)
        tableview.delegate = self as UITableViewDelegate
        tableview.dataSource = self as UITableViewDataSource
        tableview.register(CountryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
       return tableview
    }()
    
    private lazy var modelList: NSArray = {
        var modelList:[SectionListModel] = self.readLocalJson()
        return modelList as NSArray
    }()
    
    private lazy var sectionIndexs: NSMutableArray = {
        var indexs: NSMutableArray = NSMutableArray()
        return indexs
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableview)
        self.formatSectionIndexs()
    }
    //MARK: 格式化分组索引
    func formatSectionIndexs(){
        for sectionItem in self.modelList{
            self.sectionIndexs.add((sectionItem as! SectionListModel).key ?? "")
        }
    }
    
    private func readLocalJson() -> [SectionListModel]{
        
        let path = Bundle.main.path(forResource: "dataList", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            /*
             * try 和 try! 的区别
             * try 发生异常会跳到catch代码中
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = jsonData as! NSArray
            let modelList: [SectionListModel] = [SectionListModel].deserialize(from: jsonArr)! as! [SectionListModel]
            return modelList
        } catch let error as Error? {
            print("读取本地数据出现错误!\(error ?? "" as! Error)")
            return []
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemModle:SectionListModel = self.modelList[section] as! SectionListModel
        return itemModle.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let itemModle:SectionListModel = self.modelList[section] as! SectionListModel
        return itemModle.key
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CountryTableViewCell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
        let itemModle:SectionListModel = self.modelList[indexPath.section] as! SectionListModel
        cell.countryInfoModel = itemModle.data?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        print("index.section ==\(indexPath.section) index.row ==\(indexPath.row)")
        let sectionModel:SectionListModel = self.modelList[indexPath.section] as! SectionListModel
        let rowModel:CountryItemModel = (sectionModel.data?[indexPath.row])!
        
        let alertVC:UIAlertController = UIAlertController(title: rowModel.countryCode, message: rowModel.countryName, preferredStyle: .actionSheet)
        let phoneCodeAction = UIAlertAction(title: rowModel.phoneCode, style: .default) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "我知道了", style: .default) { (action) in
            
        }
        alertVC.addAction(phoneCodeAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    //显示右侧索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionIndexs as? [String]
    }
    //点击索引之后的响应事件
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: index) as IndexPath, at: .top, animated: true)
        return index
    }
    
}

