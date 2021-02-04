//
//  HomeCollectionViewCell.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var commonStackView: UIStackView?
    @IBOutlet var authorLabel: UILabel?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var thumbnailImage: UIImageView?
    @IBOutlet var thumbnailAspectRatio: NSLayoutConstraint?
    @IBOutlet var commentsLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - CGFloat(30))
        self.addConstraint(widthConstraint)
        let commonStackWidth = NSLayoutConstraint(item: self.commonStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - CGFloat(60))
        self.commonStackView?.addConstraint(commonStackWidth)
    }

    public func setData(_ data: HomeCellData){
        self.authorLabel?.text = "Author: \(data.authorName) \n\(self.generatePublishingTime(data.entryDate))"
        self.titleLabel?.text = data.title
        if let image = data.image {
            self.setImage(image)
        } 
        self.commentsLabel?.text = "Now: \(data.numberComments) comments"
        setImageConstraints(width: CGFloat(data.thumbnailWidth), height: CGFloat(data.thumbnailHeight))
    }
    
    public func setImage(_ imageData: Data){
        self.thumbnailImage?.image = UIImage(data: imageData)
    }
    
    // MARK: -
    // MARK: Private Methods
    
    private func setImageConstraints(width: CGFloat, height: CGFloat) {
        guard let thumbnail = self.thumbnailImage else {return}
//        let widthConstraint = NSLayoutConstraint(item: thumbnail, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
        let heightConstraint = NSLayoutConstraint(item: thumbnail, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
        self.thumbnailImage?.removeConstraints(self.thumbnailImage?.constraints ?? [])
        self.thumbnailImage?.addConstraints(
            [//widthConstraint,
             heightConstraint]
        )
    }
    
    private func generatePublishingTime(_ inputDate: Int)->String{
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day,.hour,.minute], from: Date(timeIntervalSince1970: TimeInterval(inputDate)), to: Date())
        var text = "Published: "
        if let day = components.day,
           day > 0 {
            text += "\(day) days, "
        }
        if let hour = components.hour,
           hour > 0 {
            text += "\(hour) hours, "
        }
        if let minutes = components.minute {
            text += "\(minutes) minutes ago"
        }
        return text
    }
}
