//
//  FactTableViewCell.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit


class FactTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let imgView = UIImageView()
    
    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = StyleKit.titleLableFont
        
        // configure descriptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = StyleKit.descLableFont
        descriptionLabel.textColor = StyleKit.lightGray
        
        //configure imageView
        contentView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 10).isActive = true
        imgView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: FactCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private func bindViewModel() {
        titleLabel.text = viewModel?.titleText ?? StyleKit.titleNotAvailableText
        descriptionLabel.text = viewModel?.descriptionText ?? StyleKit.descNotAvailableText
        if let imageString = viewModel?.imageHrefUrl {
            imgView.downloaded(from: imageString)
        }
    }
}


