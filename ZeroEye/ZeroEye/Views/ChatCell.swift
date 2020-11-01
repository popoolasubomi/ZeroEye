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
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorBubbleView: UIView!
    @IBOutlet weak var authorChatLabel: UILabel!
    
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
        
        self.authorBubbleView.layer.cornerRadius = 26
        self.authorBubbleView.clipsToBounds = true
        
        let composer = message["author"] as! PFUser
        
        if (PFUser.current()?.username == composer.username) {
            self.usernameLabel.alpha = 0
            self.chatLabel.alpha = 0
            self.bubbleView.alpha = 0
            
            self.authorNameLabel.text = composer.username
            
            let chatData = message["Chats"] as? [String]
            if (self.isEncrypted!) {
                self.authorChatLabel.text = Cryptograph.sharedInstance.joinStrings(text: chatData!)
            } else {
                self.authorChatLabel.text = Cryptograph.sharedInstance.decryptText(text: chatData!)
            }
           
            self.authorBubbleView.alpha = 1
            self.authorNameLabel.alpha = 1
            self.authorChatLabel.alpha = 1
            
        } else {
            self.usernameLabel.alpha = 1
            self.chatLabel.alpha = 1
            self.bubbleView.alpha = 1
            
            self.usernameLabel.text = composer.username
            
            let chatData = message["Chats"] as? [String]
            if (self.isEncrypted!) {
                self.chatLabel.text = Cryptograph.sharedInstance.joinStrings(text: chatData!)
            } else {
                self.chatLabel.text = Cryptograph.sharedInstance.decryptText(text: chatData!)
            }
            
            self.authorBubbleView.alpha = 0
            self.authorNameLabel.alpha = 0
            self.authorChatLabel.alpha = 0
        }
    }
}
