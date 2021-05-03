//
//  SupervisorhomeView.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class SupervisorhomeView: UIViewController {
    
    var wkdet = [wkdetails]()
    var undet = [undetails]()
    var fcdet = [fcdetails]()
    var emp_dept:String?
    var tech_count:String?
    var indexPath = IndexPath()
    
    
    
    @IBOutlet weak var wkbtn: UIButton!
    @IBOutlet weak var unassignbtn: UIButton!
    @IBOutlet weak var fcbtn: UIButton!
    @IBOutlet weak var techbtn: UIButton!
    
    @IBOutlet weak var wkView: UIView!
    @IBOutlet weak var unassignedView: UIView!
    @IBOutlet weak var fieldcompletionView: UIView!
    @IBOutlet weak var technicianView: UIView!
    
    @IBOutlet weak var wkcountlab: UILabel!
    @IBOutlet weak var fieldcompletionCountlab: UILabel!
    @IBOutlet weak var techniciancountlab: UILabel!
    @IBOutlet weak var unassignedcountlab: UILabel!

    @IBAction func unwindToMenu1(segue: UIStoryboardSegue) {
             
    }

    @IBAction func Workorders(_ sender: Any) {
        performSegue(withIdentifier: "workorders", sender: self)
        print("wk tapped")
    }
    
    @IBAction func UnassignedWorkorders(_ sender: Any) {
        performSegue(withIdentifier: "unassigned", sender: self)
        print("unassigned tapped")
    }
    
    @IBAction func FieldCompletion(_ sender: Any) {
        performSegue(withIdentifier: "fieldcompletion", sender: self)
        
        print("fc tapped")
    }
    
    @IBAction func Technicians(_ sender: Any) {
        performSegue(withIdentifier: "technicians", sender: self)
        print("technician tapped")
    }
    
    @IBAction func snotificationTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "snotify", sender: self)
        
    }
    
    
     override func viewWillAppear(_ animated: Bool) {
      
        downloadItems()
        undownloadItems()
        fcdownloadItems()
       Technicians_count()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        wkView.layer.masksToBounds = false
        wkView.layer.shadowRadius = 4
        wkView.layer.shadowOpacity = 1
        wkView.layer.shadowColor = UIColor.gray.cgColor
        wkView.layer.shadowOffset = CGSize(width: 0 , height:6)
        wkView.layer.borderWidth = 0.5
        wkView.layer.borderColor = UIColor.black.cgColor
        wkView.addSubview(wkbtn)
        
        
        unassignedView.layer.masksToBounds = false
        unassignedView.layer.shadowRadius = 4
        unassignedView.layer.shadowOpacity = 1
        unassignedView.layer.shadowColor = UIColor.gray.cgColor
        unassignedView.layer.shadowOffset = CGSize(width: 0 , height:6)
        unassignedView.layer.borderWidth = 0.5
        unassignedView.layer.borderColor = UIColor.black.cgColor
        unassignedView.addSubview(unassignbtn)
        
        fieldcompletionView.layer.masksToBounds = false
        fieldcompletionView.layer.shadowRadius = 4
        fieldcompletionView.layer.shadowOpacity = 1
        fieldcompletionView.layer.shadowColor = UIColor.gray.cgColor
        fieldcompletionView.layer.shadowOffset = CGSize(width: 0 , height:6)
        fieldcompletionView.layer.borderWidth = 0.5
        fieldcompletionView.layer.borderColor = UIColor.black.cgColor
        fieldcompletionView.addSubview(fcbtn)
        
        technicianView.layer.masksToBounds = false
        technicianView.layer.shadowRadius = 4
        technicianView.layer.shadowOpacity = 1
        technicianView.layer.shadowColor = UIColor.gray.cgColor
        technicianView.layer.shadowOffset = CGSize(width: 0 , height:6)
        technicianView.layer.borderWidth = 0.2
        technicianView.layer.borderColor = UIColor.black.cgColor
        technicianView.addSubview(techbtn)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.removeSpinner()
        
    }
    
    
    func downloadItems() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}

        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisor_totalworkorder.php")! as URL)
               request.httpMethod = "POST"
               let postString = "employee_id=\(employee_id)"
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
      //     let stocks = NSMutableArray()
           for i in 0 ..< jsonResult.count
                {
               print("The count is \(jsonResult.count)")
               jsonElement = jsonResult[i] as! NSDictionary
                   //the following insures none of the JsonElement values are nil through optional binding
               let work_order_count = jsonElement["work_order_count"] as? String

            
            wkdet.append(wkdetails(work_order_count: work_order_count))

               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
  
            for i in wkdet{
                
                self.wkcountlab.text = i.work_order_count
               
            }
           })
           }
    
    
    func undownloadItems() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}

        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisor_unassigned_count.php")! as URL)
               request.httpMethod = "POST"
               let postString = "employee_token=\(employee_id)"
               print("postString \(postString)")
               request.httpBody = postString.data(using: String.Encoding.utf8)
           let task = URLSession.shared.dataTask(with: request as URLRequest) {
                 data, response, error in
                 if error != nil {
                   print("error=\(String(describing: error))")
                   return
                 }
                 self.unparseJSON(data!)
                 print("response = \(String(describing: response))")
                 let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("responseString = \(String(describing: responseString))")
               }
               task.resume()
           
       }
   
       
       func unparseJSON(_ data:Data) {
           var jsonResult = NSArray()
               do{
                   jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
               } catch let error as NSError {
                   print(error)
               }
               var jsonElement = NSDictionary()
       //    let stocks = NSMutableArray()
           for i in 0 ..< jsonResult.count
                {
               print("The count is \(jsonResult.count)")
               jsonElement = jsonResult[i] as! NSDictionary
                   //the following insures none of the JsonElement values are nil through optional binding
               let unassigned_count = jsonElement["unassigned_count"] as? String

            
            undet.append(undetails(unassigned_count: unassigned_count))
             
                
                   
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
  
            for i in undet{
                
                self.unassignedcountlab.text = i.unassigned_count
               
            }
           })
           }
    
    
    func fcdownloadItems() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}

        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisor_completed_count.php")! as URL)
               request.httpMethod = "POST"
               let postString = "employee_token=\(employee_id)"
               print("postString \(postString)")
               request.httpBody = postString.data(using: String.Encoding.utf8)
           let task = URLSession.shared.dataTask(with: request as URLRequest) {
                 data, response, error in
                 if error != nil {
                   print("error=\(String(describing: error))")
                   return
                 }
                 self.fcparseJSON(data!)
                 print("response = \(String(describing: response))")
                 let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("responseString = \(String(describing: responseString))")
               }
               task.resume()
           
       }
   
       
       func fcparseJSON(_ data:Data) {
           var jsonResult = NSArray()
               do{
                   jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
               } catch let error as NSError {
                   print(error)
               }
               var jsonElement = NSDictionary()
         //  let stocks = NSMutableArray()
           for i in 0 ..< jsonResult.count
                {
               print("The count is \(jsonResult.count)")
               jsonElement = jsonResult[i] as! NSDictionary
                   //the following insures none of the JsonElement values are nil through optional binding
               let completed_count = jsonElement["completed_count"] as? String

            
            fcdet.append(fcdetails(completed_count: completed_count))
             
                
                   
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
  
            for i in fcdet{
                
                self.fieldcompletionCountlab.text = i.completed_count
               
            }
           })
        
           }
    func Technicians_count(){
           guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/iOS_Supervisor_HomeScreen_Technician_Count.php")! as URL)
               request.httpMethod = "POST"
           let postString = "employee_id=\(employee_id)"
               print("Technicians_countpostString \(postString)")
               request.httpBody = postString.data(using: String.Encoding.utf8)
           let task = URLSession.shared.dataTask(with: request as URLRequest) {
                 data, response, error in
                 if error != nil {
                   print("error=\(String(describing: error))")
                   return
                 }
                 self.Technicians_countJSON(data!)
                 print("Technicians_count response = \(String(describing: response))")
                 let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("Technicians_count responseString = \(String(describing: responseString))")
               }
               task.resume()
       }
       func Technicians_countJSON(_ data:Data) {
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
               tech_count = jsonElement["tech_count"] as? String
               emp_dept = jsonElement["emp_dept"] as? String
               print("Technicians_countJSON : \(jsonElement["tech_count"] as? String)")
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
            techniciancountlab.text = "\(tech_count ?? "0")"
               UserDefaults.standard.set(emp_dept, forKey: "emp_dept")
           })
           }
/*    func technicianJSON(_ data:Data) {
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
            tech_count = jsonElement["tech_count"] as? String
            print("tech_count \(tech_count)")
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            techniciancountlab.text = "\(tech_count!)"
        })
     }
*/
 /*   func supervisior_Dept() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisor_Depart.php")! as URL)
            request.httpMethod = "POST"
        let postString = "employee_id=\(employee_id)"
        
            print("supervisior_Dept \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              self.supervisiorJSON(data!)
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    */
   /* func supervisiorJSON(_ data:Data) {
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
            emp_dept = jsonElement["emp_dept"] as? String
            print("emp_dept : \(emp_dept)")
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            
        })
        print("supervisior_emp_dept : \(emp_dept!)")
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_Technician_Count.php")! as URL)
            request.httpMethod = "POST"
        let postString = "emp_dept=\(emp_dept!)"
        UserDefaults.standard.set(emp_dept, forKey: "emp_dept")

            print("technician_count_postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              self.technicianJSON(data!)
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    */

}
struct wkdetails{
    var work_order_count: String?
}
struct undetails{
    var unassigned_count: String?
}
struct fcdetails{
    var completed_count: String?
}
