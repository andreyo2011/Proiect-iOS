//
//  SearchController.swift
//  Laborator3
//
//  Created by user216460 on 9/12/22.
//


import UIKit
import CoreData

final class FavoriteLinesViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    private var model: [LineEntity] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getAllModels()
    }
    
    private func configure(){
        
        title = "Linii favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FavoriteLineTableViewCell.self, forCellReuseIdentifier: FavoriteLineTableViewCell.cellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllModels()
    }
    
    private func getAllModels(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = LineEntity.fetchRequest()
      
        do{
            model = try managedContext.fetch(fetchRequest)
          
        }catch{
            print("here::",error.localizedDescription)
            
        }
        
    }
    
    private func navigate(item: Line){
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LineStopsController")
        as? LineStopsViewController else {return}
        viewController.item = item
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


extension FavoriteLinesViewController: UITextFieldDelegate{
    
}

extension FavoriteLinesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteLineTableViewCell.cellId, for: indexPath)
                as? FavoriteLineTableViewCell else { return UITableViewCell() }
        let cellModel = model[indexPath.row]
        cell.setup(lineEntity: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        var line: Line = Line(id: Int(model[indexPath.row].id), name: (model[indexPath.row].name ?? "Necunoscut"), type:  (model[indexPath.row].type ?? "Necunoscut"));
        navigate(item: line)
    }
}
