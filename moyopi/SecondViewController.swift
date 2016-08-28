//
//  SecondViewController.swift
//  moyopi
//
//  Created by Keishi Mitsuhashi on 2016/08/28.
//  Copyright © 2016年 kebabees. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedText: String?
    var selectedId: Int?
    
    var selectedRow: NSIndexPath?
    
    // セクション名
    let sections = ["イベント一覧"]
    
    let texts: [(id: Int, name: String)] = [
        (1,"イベント１"),
        (2,"イベント２"),
        (3,"イベント３")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // selectedRowがセットされていたら選択を解除する
        if (selectedRow != nil)
        {
            tableView?.deselectRowAtIndexPath(selectedRow!, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    // セクションの数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = texts[indexPath.row].name
        return cell
    }
    
    // セクションの名前
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        // SecondViewControllerに渡す文字列をセット
        selectedText = texts[indexPath.row].name
        selectedId = texts[indexPath.row].id
        
        // SecondViewControllerへ遷移するSegueを呼び出す
        performSegueWithIdentifier("showSecondView",sender: nil)
        
        // 選択状態を解除するIndexPathをセット
        selectedRow = indexPath
    }
    
    // Segueで遷移時の処理
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showSecondView") {
            let secondVC: SecondViewController = (segue.destinationViewController as? SecondViewController)!
            
            // SecondViewControllerのtextに選択した文字列を設定する
            //secondVC.text = selectedText
            //secondVC.id = selectedId
        }
    }
}

