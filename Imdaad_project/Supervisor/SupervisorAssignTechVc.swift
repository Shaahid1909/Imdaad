//
//  SupervisorAssignTechVc.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorAssignTechVc: UIViewController,UITableViewDelegate,UITableViewDataSource,assigned_tech_names,UISearchBarDelegate{
    var Selected_names = [String]()
    var unwkorder = [unworkorderData]()
    var atemp_id: String?
    var urlpath:String?
    
    @IBOutlet weak var attabView: UITableView!
    @IBOutlet weak var searchtechnicians: UISearchBar!

    var Selected_id = [String]()
    var searching = [assign_name_list]()
    var assign_name = [assign_name_list]()
    var work_count = [String]()
    
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     
    }
    //    override func viewWillAppear(_ animated: Bool) {
//
//        wkorder.removeAll()
//        downloadItems()
//        tabView.reloadData()
//
//    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // createnotify()
        attabView.reloadData()
        attabView.delegate = self
        attabView.dataSource = self
        searchtechnicians.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searching.removeAll()
        assign_name.removeAll()
        downloadItems()
        attabView.reloadData()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return assign_name.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "atwkorder", for: indexPath) as! SupervisorAssignTechCell

        cell.atname.text = assign_name[indexPath.row].name
        cell.atkm.text = assign_name[indexPath.row].distance
        cell.CellDelegate = self
        cell.indexPath = indexPath
            
                return cell
            
        
        
    }

    func Assign_names(cell: SupervisorAssignTechCell, didTappedThe button: UIButton?) {
        if button?.isSelected != true{
            guard let indexPath = attabView.indexPath(for: cell) else  { return }
            Selected_names = Selected_names.filter() {$0 != assign_name[indexPath.row].name!}
            Selected_id = Selected_id.filter() {$0 != assign_name[indexPath.row].emp_id!}

            print("Title : \(indexPath.row) \n Deselected  : \(assign_name[indexPath.row].name) \(assign_name[indexPath.row].emp_id) \(Selected_names)")
            }else if button?.isSelected != false{
                   guard let indexPath = attabView.indexPath(for: cell) else  { return }
                    Selected_names.append(assign_name[indexPath.row].name!)
                Selected_id.append(assign_name[indexPath.row].emp_id!)
                    print("Title : \(indexPath.row) \n Seleceted : \(assign_name[indexPath.row].name) \(assign_name[indexPath.row].emp_id) \(Selected_names)")
                }
    }
    
    
    
    
    
    
    
    @IBAction func AssignBtnTapped(_ sender: Any) {
       
        guard let token_id = UserDefaults.standard.value(forKey: "token_id") as? String else {return}
        for (i,j) in zip(Selected_id, Selected_names){
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Imdaad_Assign_Technician_update.php")! as URL)
            request.httpMethod = "POST"
            let postString = "work_type_token=\(token_id)&status_token=assign&technician_name=\(j)&technician_token=\(i)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
                    if error != nil {
                    print("error=\(String(describing: error))")
                    return
                    }
               
                    print("response = \(String(describing: response))")
                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("responseString = \(String(describing: responseString))")
                self.workorderupdate()
                self.createnotify()
                
                
                
            }
                    task.resume()
            let alert = UIAlertController(title: "", message: "Technician Assigned Successfully", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK",style:UIAlertAction.Style.default, handler: {
            (_)in
                 self.performSegue(withIdentifier: "unwindToMenu", sender: self)
             })
         
            alert.addAction(OKAction)
           self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func createnotify() {
        
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
        
        guard let token_id = UserDefaults.standard.value(forKey: "token_id") as? String else {return}
        for (i,j) in zip(Selected_id, Selected_names){
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/notification-create.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_token=\(i)&work_order_token=\(token_id)&title=New Workorder assigned&is_seen=0&id=\(employee_id)&message=Workorder \(token_id) has been assigned to you by the..."
            print("postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    }
    func workorderupdate(){
        var digit:String?
        for (i,j) in zip(Selected_id, work_count){
          digit = String(Int(j)!+1)
          print("digit : \(digit) \(i) \(j)")
          let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/imdaad_workorder_update.php")! as URL)
          request.httpMethod = "POST"
          let postString = "work_order_count=\(digit!)&employee_id=\(i)"
          request.httpBody = postString.data(using: String.Encoding.utf8)
          let task = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
              if error != nil {
              print("error=\(String(describing: error))")
              return
              }
              print("insert_notification response = \(String(describing: response)) \(postString)")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("insert_notification = \(String(describing: responseString))")
              }
              task.resume()
        }
      }
    
    
    func downloadItems() {
        guard let emp_dept = UserDefaults.standard.value(forKey: "emp_dept") as? String else {return}
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/Imdaad_assign_Technician_list.php")! as URL)
            request.httpMethod = "POST"
        let postString = "emp_dept=\(emp_dept)"
        
            print("postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              self.parseJSON(data!)
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()

            }

    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
    let stocks = NSMutableArray()
    for i in 0 ..< jsonResult.count
         {
        jsonElement = jsonResult[i] as! NSDictionary
        assign_name.append(assign_name_list(name: jsonElement["name"] as? String, distance: "1.2 km", emp_id: jsonElement["employee_id"] as? String))
        searching.append(assign_name_list(name: jsonElement["name"] as? String, distance: "1.2 km", emp_id: jsonElement["employee_id"] as? String))
        print("assign_name : \(assign_name)")
        }
    DispatchQueue.main.async(execute: { [self] () -> Void in
        itemsDownloaded(items: stocks)
    })
    }
func itemsDownloaded(items: NSArray) {
   
    self.attabView.reloadData()
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      guard !searchText.isEmpty else{
        assign_name = searching
        attabView.reloadData()
          return
        }
        assign_name = searching.filter({ assign_name_list -> Bool in
            assign_name_list.name!.contains(searchText)
        })
        attabView.reloadData()
        }
}
    


struct assign_name_list {
    var name:String?
    var distance:String?
    var emp_id:String?
}
