//
//  FactTableViewCell.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit

class FactTableViewCell: UITableViewCell {
    
    let dataImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    let dataTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return titleLabel
    }()
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: "Times New Roman", size: 15)
        descriptionLabel.textColor = UIColor.gray
        return descriptionLabel
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(dataTitleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(dataImageView)
        let views = ["lbl1": dataTitleLabel,
                     "lbl2": descriptionLabel,
                     "img": dataImageView
            ] as [String : Any]
        let hString1 = "H:|-30-[lbl1]-20-[img(70)]-50-|"
        let hString2 = "H:|-30-[lbl2]-20-[img(70)]-50-|"
        let vString1 = "V:|-10-[lbl1(25)]-10-[lbl2]-10-|"
        let vString2 = "V:|-10-[img]-10-|"
        var constraints = [NSLayoutConstraint]()
        let hConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: hString1, metrics: nil, views: views)
        let hConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: hString2, metrics: nil, views: views)
        let vConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: vString1, metrics: nil, views: views)
        let vConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: vString2, metrics: nil, views: views)
        constraints += hConstraint1
        constraints += hConstraint2
        constraints += vConstraint1
        constraints += vConstraint2
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataImageView.image = nil
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
        dataTitleLabel.text = viewModel?.titleText ?? "Title Not Available"
        descriptionLabel.text = viewModel?.descriptionText ?? "Description Not Available"
        if let imageString = viewModel?.imageHrefUrl {
            dataImageView.downloaded(from: imageString)
        }
    }
}

