//
//  SearchTableViewCell.swift
//  Laborator3
//
//  Created by user216460 on 9/12/22.
//


import UIKit


final class FavoriteLineTableViewCell: UITableViewCell{
    
    static let cellId = "FavoriteLineTableViewCell"
    private let lineLabel = UILabel()
    private let typeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    

    
    func setup(lineEntity: LineEntity){
        lineLabel.text = "Linia \(lineEntity.name ?? "Necunoscut")"
        
        var type: String = ""
        if lineEntity.type == "BUS"{
            type = "Autobuz"
        }
        else if lineEntity.type == "TRAM"{
            type = "Tramvai"
        }
        else if lineEntity.type == "CABLE_CAR"{
            type = "Troleibuz"
        }
        else if lineEntity.type == "SUBWAY"{
            type = "Metrou"
        }
        else{
            type = "Necunoscut"
        }
            
        typeLabel.text = type
        
    }
    
    override var reuseIdentifier: String?{
        return FavoriteLineTableViewCell.cellId
    }
    
    required init?(coder: NSCoder){
        fatalError("init::coder has not been implemented")
    }
}


private extension FavoriteLineTableViewCell{
    func configure(){
        lineLabel.font = UIFont.systemFont(ofSize: 23)
        lineLabel.numberOfLines = 2
      
        
        typeLabel.font = UIFont.systemFont(ofSize: 15)
        typeLabel.numberOfLines = 1
    

        typeLabel.textColor = UIColor.secondaryLabel

        
        contentView.addSubview(lineLabel)
        contentView.addSubview(typeLabel)
        
        lineLabel.translatesAutoresizingMaskIntoConstraints = false
        lineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        lineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: lineLabel.bottomAnchor, constant: 5).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: lineLabel.rightAnchor, constant: -5).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }}
