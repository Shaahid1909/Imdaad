//
//  SupervisorTechListVc.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorTechListVc: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var Technician = [Technician_list]()
    var name:String?
    var work_counts:String?
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.delegate = self
        collectView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Technician.removeAll()
        downloadItems()
        collectView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Technician.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 194, height: 198)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath) as! SupervisorTechListCollCell
        cell.namelab.text = Technician[indexPath.row].name
        cell.countlab.text = Technician[indexPath.row].count_workorder
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "techdetView", sender: self)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "techdetView"{
            let VC = segue.destination as! SupervisorTechnicianWkView
            if let collectionView = self.collectView,
                let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let cell = collectionView.cellForItem(at: indexPath) as? SupervisorTechListCollCell {
                VC.name = Technician[indexPath.row].name
                VC.work_counts = Technician[indexPath.row].count_workorder
                VC.id = Technician[indexPath.row].employee_id
                print(VC.id)
            }
           
        }
    }

    func downloadItems() {
        guard let emp_dept = UserDefaults.standard.value(forKey: "emp_dept") as? String else {return}
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisor_technician_workoreder_list.php")! as URL)
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
            Technician.append(Technician_list(employee_id: jsonElement["employee_id"] as? String, name: jsonElement["name"] as? String, count_workorder: jsonElement["work_order_count"] as? String))
            
    
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            itemsDownloaded(items: stocks)
        })
        }
    func itemsDownloaded(items: NSArray) {
       
        self.collectView.reloadData()
      }
   
   
    
    
    
}
struct Technician_list{
    var employee_id:String?
    var name:String?
    var count_workorder:String?
}
