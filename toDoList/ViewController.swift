//
//  ViewController.swift
//  toDoList
//
//  Created by swift on 23.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
  
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    var items = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "keep in mind"
        
        view.addSubview(table)
        table.dataSource = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didtapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didtapAdd))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    @objc private func didtapAdd() {
        let alert = UIAlertController(title: "Новая запись", message: "Введите новую запись", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler: {[weak self] (_) in
                                      if let field = alert.textFields?.first {
                                          if let text = field.text, !text.isEmpty {
                                              DispatchQueue.main.async {
                                                  var currentItem = UserDefaults.standard.stringArray(forKey: "items") ?? []
                                                  currentItem.append(text)
                                                  UserDefaults.standard.setValue(currentItem, forKey: "items")
                                                  self?.items.append(text)
                                                  self?.table.reloadData()
                                                  
                                              }
                                          }
                                      }
                                      }))
                                      alert.addTextField { field in
            field.placeholder = "Введите запись..."
        }
                present(alert, animated: true)
                                      
                                      }
                                    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

