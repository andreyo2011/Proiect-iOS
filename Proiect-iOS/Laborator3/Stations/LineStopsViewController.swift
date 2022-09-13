//
//  LineStopsController.swift
//  Laborator3
//
//  Created by user216460 on 9/6/22.
//



import UIKit
import CoreData

struct StopsModel: Decodable{
    var stops: [Stop] = []
}


struct Stop: Decodable{
    let id: Int
    let name: String
    let description: String

    
}
class LineStopsViewController: UIViewController {
    
    
    private var model = StopsModel()

       
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var item: Line!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestItems()
      
    }
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        addLine()
        addButton.rotate()
    }
    
    
    
    @IBAction func deleteFromFavorites(_ sender: Any) {
        deleteLine()
    }
    
    private func deleteLine(){
    
    }
    
    private func addLine(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "LineEntity", in: managedContext),
        let item = item else {return}
        let lineEntity = LineEntity(entity: entity, insertInto: managedContext)
        
        lineEntity.id = Int64(item.id)
        lineEntity.name = item.name
        lineEntity.type = item.type
       

        do{
            try managedContext.save()
            
        }catch{
            print("here::",error.localizedDescription)
        }
    }
    
    private func requestItems(){
       
        let pathString = "https://info.stbsa.ro/rp/api/lines/\(String(item.id))"
        let url = URL(string: pathString)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let _ = error{
                return
            }
            
            let jsonDecoder = JSONDecoder()
    
            guard let data = data else {return}
            guard let welf = self else {return}

            guard let stops = try? jsonDecoder.decode(StopsModel.self, from: data) else {return}
            welf.model.stops = stops.stops
            DispatchQueue.main.async {
                welf.tableView.reloadData()
                
            }
        
        }
        task.resume()
    }
    
    private func configure(){
        
        guard let item = item else {
            return
        }
 
        title = "Statii linia \(item.name)"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LineStopsTableViewCell.self, forCellReuseIdentifier: LineStopsTableViewCell.cellId)
    }
    
}

extension LineStopsViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineStopsTableViewCell.cellId, for: indexPath) as? LineStopsTableViewCell else {return UITableViewCell()}
        let cellModel = model.stops[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return model.stops.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension UIButton{
    func rotate(){
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.repeatCount = 2
        self.layer.add(rotation, forKey: "rotateAnimation")
    }
}














