//
//  SepetTableViewCell.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 31.03.2022.
//

import UIKit

class SepetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sepetUrunResimImageView: UIImageView!
    @IBOutlet weak var sepetUrunIsımLabel: UILabel!
    @IBOutlet weak var sepetUrunAdetLabel: UILabel!
    @IBOutlet weak var sepetUrunTutarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
