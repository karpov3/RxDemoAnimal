//
//  AnimalTableViewCell.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import UIKit

public class AnimalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var animal: UILabel!

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
   
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
