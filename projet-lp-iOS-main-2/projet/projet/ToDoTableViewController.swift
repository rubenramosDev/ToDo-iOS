

import UIKit


class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customIm: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var isChecked = false
    
}

class ToDoTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputText: UITextField!
    
    var tasks = ToDo.loadSampleToDos()
    var indexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let newTask = inputText.text, !newTask.isEmpty {
            tasks.append(ToDo(titre: newTask, etat: false));
            tableView.reloadData();
        } else {
            let alert = UIAlertController(title: "ToDo", message: "Task is empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        return true;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! TaskTableViewCell
        
        let InTask = tasks[indexPath.row]
        cell.label?.text = InTask.titre
        cell.customIm?.image = UIImage(named: "circle2")
        cell.isChecked = false
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        
        if cell.isChecked == false {
            cell.customIm?.image = UIImage(named: "thick")
            cell.isChecked = true
        } else {
            cell.customIm?.image = UIImage(named: "circle2")
            cell.isChecked = false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            if cell.isChecked == true {
              tasks.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
            }
          }
      }

    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedLandmark = tasks.remove(at: fromIndexPath.row)
        tasks.insert(movedLandmark, at: to.row)
        tableView.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        indexSelected = tableView.indexPathForSelectedRow!.row
        
         let selectedIndexPath = tableView.indexPathForSelectedRow!
           let selectedTask = tasks[selectedIndexPath.row]
        
          let detailVC = segue.destination as! TaskViewController
          detailVC.task = selectedTask
                
    }
    
    func reloadRows(with animation: UITableView.RowAnimation){
        tableView.reloadData()
    }
    
    //Make changes. Method must work in the other way
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
        var taskViewController = segue.source as! TaskViewController
        
        var objectToDo = taskViewController.task
                    
        tasks[indexSelected].derniereMod = Date()
        tasks[indexSelected].titre = objectToDo!.titre
        
        
        tableView.reloadData()
        //let selectedIndexPath = tableView.indexPathForSelectedRow!
       // tableView.reloadRows(at: [selectedIndexPath], with: .none)
        
        }
    }
    
    

