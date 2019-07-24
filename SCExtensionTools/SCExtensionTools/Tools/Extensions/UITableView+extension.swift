//
//  UITableView+extension.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 7/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func hideSeparatorWhenEmpty(count: Int){
        separatorStyle = count > 0 ? UITableViewCell.SeparatorStyle.singleLine : .none
    }
    
    func cancelAllSelections(){
        for section in 0..<numberOfSections{
            for row in 0..<numberOfRows(inSection: section){
                let cell = cellForRow(at: IndexPath(row: row, section: section))
                cell?.isSelected = false
            }
        }
    }
    
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
    func scroll2Top(){
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
