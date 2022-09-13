//
//  LineStopsTableViewCell.swift
//  Laborator3
//
//  Created by user216460 on 9/6/22.
//


import UIKit


class LineStopsTableViewCell:UITableViewCell{
    static let cellId = "LineStopsTableViewCell"
    
    let stationLabel = UILabel()
    let locationLabel = UILabel()

    let accesorryImageView = UIImageView()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setUp(with model:Stop){
        stationLabel.text = "Statia \(String(model.name))"
        locationLabel.text = model.description
    }
  
    override var reuseIdentifier: String?{
        return LineStopsTableViewCell.cellId
    }
    
    required init(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}

private extension LineStopsTableViewCell{
    func configure(){
        stationLabel.font = UIFont.systemFont(ofSize: 23)
        stationLabel.numberOfLines = 2
        
        locationLabel.font = UIFont.systemFont(ofSize: 15)
        locationLabel.numberOfLines = 1
        
        
        locationLabel.textColor = UIColor.secondaryLabel

        
        contentView.addSubview(stationLabel)
        contentView.addSubview(locationLabel)
        
        stationLabel.translatesAutoresizingMaskIntoConstraints = false
        stationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        stationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true

        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 5).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: stationLabel.rightAnchor, constant: -5).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }}
