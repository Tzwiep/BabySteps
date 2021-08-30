//
//  MilestoneTableViewCell.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit

class MilestoneTableViewCell: UITableViewCell {

    
    @IBOutlet weak var marginView: UIView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var momentImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // style card cell
        cardView.layer.cornerRadius = 5
        
        // style margin cell
        marginView.layer.cornerRadius = 5
        marginView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        marginView.layer.shadowRadius = 5
        marginView.layer.shadowOpacity = 0.5
        marginView.layer.shadowOffset = .zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // method for setting custom cell
    func setTableCell(_ m:Milestone) {
        
        // set the image
        self.momentImage.image = UIImage(data: m.image!)
        
        //set the label
        self.titleLabel.text = m.title
    }

}
