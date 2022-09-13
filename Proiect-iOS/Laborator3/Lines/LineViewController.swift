
//
//  ViewController.swift
//  Laborator3
//
//  Created by user216460 on 8/31/22.
//

import UIKit


struct LinesModel: Decodable{
    var lines: [Line] = []
}


struct Line: Decodable{
    var id: Int
    var name: String
    var type: String

    
}
class LineViewController: UIViewController {
    
    
    private var model = LinesModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestItems()
    }
    
    private func requestItems(){
 
        let pathString = "https://info.stbsa.ro/rp/api/lines"
        let url = URL(string: pathString)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let _ = error{
                return
            }
            
            let jsonDecoder = JSONDecoder()
    
            guard let data = data else {return}
            guard let welf = self else {return}

            guard let lines = try? jsonDecoder.decode(LinesModel.self, from: data) else {return}
            welf.model.lines = lines.lines
            DispatchQueue.main.async {
                welf.tableView.reloadData()
                
            }
        
        
        }
        task.resume()
    }
    
    private func configure(){
        title = "Linii STB"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LineTableViewCell.self, forCellReuseIdentifier: LineTableViewCell.cellId)
    }
    
    private func navigate(item: Line){
       
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LineStopsController")
        as? LineStopsViewController else {return}
        viewController.item = item
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension LineViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineTableViewCell.cellId, for: indexPath) as? LineTableViewCell else {return UITableViewCell()}
        let cellModel = model.lines[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return model.lines.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let item = model.lines[indexPath.row]
        navigate(item: item)
    }
}



























































