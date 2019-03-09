//
//  ViewController.swift
//  TakusanYometane
//
//  Created by Keita Sakamoto on 2018/09/03.
//  Copyright © 2018年 Keita Sakamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var bookNameInput: UITextField!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet var bookNameList: [UITableView]!
    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bookNameSearchBtn(_ sender: Any) {
        let title = bookNameInput.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = "https://www.googleapis.com/books/v1/volumes?q=intitle:\(title!)"
        getURL(url: url)
    }
    
    func getURL(url: String) {
        do {
            let apiURL = URL(string:url)!
            let data = try Data(contentsOf: apiURL)
            let json = try JSONSerialization.jsonObject(with: data) as! NSDictionary
            let items = json["items"] as! NSArray
            
            for item in items {
                let dicItem = item as! NSDictionary
                let volumeInfo = dicItem["volumeInfo"] as! [String: Any]
                let title = volumeInfo["title"]
                print(title as! String)
                titles[(item as AnyObject).count] = title as! String
//                self.bookNameLabel.text = title as? String
            }
            
            
            //            let title: String = items["0"].title
            //            let query = json["query"] as! [String:Any]
            //            let title = query["title"] as! [String: Any]
            
            
        } catch {
            self.bookNameLabel.text = "サーバーに接続できません"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = titles[indexPath.row]
        return cell
    }
}

