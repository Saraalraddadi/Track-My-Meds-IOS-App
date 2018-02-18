//
//  medicineTableViewCell.swift
//  TrackMyMeds
//


import UIKit

class medicineTableViewCell: UITableViewCell {
    @IBOutlet weak var mediImgView: UIImageView!
    @IBOutlet weak var mediName: UILabel!
    @IBOutlet weak var mediDoseInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mediImgView.clipsToBounds = true
        mediImgView.layer.cornerRadius = mediImgView.frame.size.width/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
