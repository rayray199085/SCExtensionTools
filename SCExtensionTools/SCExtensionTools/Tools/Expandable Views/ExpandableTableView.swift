//
//  SampleThreePartTableViewController.swift
//  DynamicCellHeight
//
//  Created by Don Mag on 3/23/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit

private let reuseIdentifier = "expandable_cell"
class ExpandableTableView: UIView, ThreePartCellDelegate {

    class func initView()->ExpandableTableView{
        let nib = UINib(nibName: "ExpandableTableView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! ExpandableTableView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBOutlet weak var tableView: UITableView!
    var myArray = [String]()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100; //Set this to any value that works for you.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ExpandableLabelCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        // create some random data
        for _ in 1...15 {
            
            let n = arc4random_uniform(6) + 4
            var str = ""
            for i in 1..<n {
                str += "Line \(i)\n"
            }
            str += "Line \(n)"
            
            myArray.append(str)
            
        }
    }
    

	// MARK: - my cell delegate
	func moreTapped(cell: ExpandableLabelCell) {
		
		// this will "refresh" the row heights, without reloading
		tableView.beginUpdates()
		tableView.endUpdates()
		
		// do anything else you want because the switch was changed
		
	}
}
extension ExpandableTableView: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExpandableLabelCell
        
        // Configure the cell...
        
        let str = myArray[indexPath.row]
        let aTmp = str.components(separatedBy: "\n")
        
        cell.myInit(theTitle: "\(indexPath) with \(aTmp.count) rows", theBody: str)
        
        cell.delegate = self
        
        return cell
    }
}
