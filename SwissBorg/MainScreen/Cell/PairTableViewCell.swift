//
//  PairTableViewCell.swift
//  SwissBorg
//
//  Created by Eduard Stern on 08.06.2022.
//

import Foundation
import UIKit

final class PairTableViewCell: UITableViewCell {

    enum Constants {
        static let margin = 16.0
        static let imageSize = 60.0
    }

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel = generateBoldLabel()
    
    private lazy var valueLabel = generateBoldLabel()

    func generateBoldLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margin),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constants.margin),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margin),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(item: Pair) {
        nameLabel.text = item.name
        valueLabel.text = "\(item.lastPrice) $"
        logoImageView.image = UIImage(named: item.name)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
