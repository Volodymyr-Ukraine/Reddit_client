//
//  HomeCollectionCell.swift
//  RedditClient
//
//  Created by Vladimir on 05.02.2021.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Internal Structures
    
    struct Sizes {
        static let standardOffset: CGFloat = 15
    }
    
    // MARK: -
    // MARK: Private Properties
    
    private let commonStackView: UIStackView = UIStackView()
    private let authorLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let thumbnailImage: UIImageView = UIImageView()
    private let commentsLabel: UILabel = UILabel()
    
    // MARK: -
    // MARK: Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    // MARK: -
    // MARK: Public Methods

    public func setData(_ data: HomeCellData){
        self.setCommonStackConstraints()
        self.authorLabel.text = "Author: \(data.authorName) \n\(self.generatePublishingTime(data.entryDate))"
        self.authorLabel.sizeToFit()
        self.titleLabel.text = data.title
        self.titleLabel.sizeToFit()
        self.commentsLabel.text = "Now: \(data.numberComments) comments"
        setImageConstraints(width: CGFloat(data.thumbnailWidth), height: CGFloat(data.thumbnailHeight))
    }
    
    public func setImage(_ imageData: Data){
        self.thumbnailImage.image = UIImage(data: imageData)
    }
    
    // MARK: -
    // MARK: Private Methods
    
    private func commonInit(){
        self.commonStackView.translatesAutoresizingMaskIntoConstraints = false
        self.commonStackView.axis = .vertical
        self.commonStackView.alignment = .fill
        self.commonStackView.distribution = .equalSpacing
        self.commonStackView.spacing = 8
        self.addSubview(self.commonStackView)
        self.addConstraints([
            NSLayoutConstraint(item: self.commonStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant:  UIScreen.main.bounds.width - CGFloat(2 * Sizes.standardOffset)),
            NSLayoutConstraint(item: self.commonStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: Sizes.standardOffset),
            NSLayoutConstraint(item: self.commonStackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.commonStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: Sizes.standardOffset),
            NSLayoutConstraint(item: self.commonStackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: Sizes.standardOffset)
        ])
        let initLabel: (UILabel)->() = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .black
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            self.commonStackView.addArrangedSubview($0)
        }
        initLabel(self.authorLabel)
        self.authorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        initLabel(self.titleLabel)
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        self.thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailImage.addConstraint(NSLayoutConstraint(item: self.thumbnailImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100))
        self.thumbnailImage.contentMode = .scaleAspectFit
        self.commonStackView.addArrangedSubview(self.thumbnailImage)
        initLabel(self.commentsLabel)
        self.commentsLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    private func setImageConstraints(width: CGFloat, height: CGFloat) {
        let thumbnail = self.thumbnailImage
        let heightConstraint = NSLayoutConstraint(item: thumbnail, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: height)
        self.thumbnailImage.removeConstraints(self.thumbnailImage.constraints)
        self.thumbnailImage.addConstraints(
            [heightConstraint]
        )
    }
    
    private func setCommonStackConstraints(){
//        guard let commonStack = self.commonStackView else {return}
        
//        self.commonStackView?.removeConstraints(commonStack.constraints)
//        self.removeConstraints(commonStack.constraints)
        
//        self.addConstraints([
//            NSLayoutConstraint(item: commonStack, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - CGFloat(60)),
//            NSLayoutConstraint(item: commonStack, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: Sizes.standardOffset),
//            NSLayoutConstraint(item: commonStack, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: Sizes.standardOffset),
//            NSLayoutConstraint(item: commonStack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0 )
//        ])
        
        
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
