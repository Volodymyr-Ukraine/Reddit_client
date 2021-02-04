//
//  HomeCollectionViewCell.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Private Properties
    
    @IBOutlet private var commonStackView: UIStackView?
    @IBOutlet private var authorLabel: UILabel?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var thumbnailImage: UIImageView?
    @IBOutlet private var commentsLabel: UILabel?
    
    // MARK: -
    // MARK: Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - CGFloat(30))
        self.addConstraint(widthConstraint)
        let commonStackWidth = NSLayoutConstraint(item: self.commonStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - CGFloat(60))
        self.commonStackView?.addConstraint(commonStackWidth)
    }
    
    // MARK: -
    // MARK: Public Methods

    public func setData(_ data: HomeCellData){
        self.authorLabel?.text = "Author: \(data.authorName) \n\(self.generatePublishingTime(data.entryDate))"
        self.titleLabel?.text = data.title
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
        let heightConstraint = NSLayoutConstraint(item: thumbnail, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
        self.thumbnailImage?.removeConstraints(self.thumbnailImage?.constraints ?? [])
        self.thumbnailImage?.addConstraints(
            [heightConstraint]
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
