//
//  ThreePartDynaTableViewCell.swift
//  DynamicCellHeight
//
//  Created by Don Mag on 3/23/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit

protocol ThreePartCellDelegate: NSObjectProtocol {
	func moreTapped(cell: ExpandableLabelCell)
}

class ExpandableLabelCell: UITableViewCell {

    @IBOutlet weak var imgHeightCons: NSLayoutConstraint!
    @IBOutlet weak var imgWidthCons: NSLayoutConstraint!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelBody: UILabel!
	
	@IBOutlet weak var buttonMore: UIButton!
	
	@IBOutlet weak var sizingLabel: UILabel!
	
	
	weak var delegate: ThreePartCellDelegate?

	var isExpanded: Bool = false
	
	@IBAction func btnMoreTapped(_ sender: Any) {
		
		if sender is UIButton {
			isExpanded = !isExpanded
			
			sizingLabel.numberOfLines = isExpanded ? 0 : 2
			buttonMore.setTitle(isExpanded ? "Read less..." : "Read more...", for: .normal)
			
			delegate?.moreTapped(cell: self)
		}
		
	}
	
	public func myInit(theTitle: String, theBody: String) {
		
		isExpanded = false
		
		labelTitle.text = theTitle
		labelBody.text = theBody
		
		labelBody.numberOfLines = 0

		sizingLabel.text = theBody
		sizingLabel.numberOfLines = 2

	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
