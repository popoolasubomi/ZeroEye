//
//  ChatCell.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    var isEncrypted: Bool?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChatCell(message: PFObject) {
        self.bubbleView.layer.cornerRadius = 16
        self.bubbleView.clipsToBounds = true
        
    }
}
