//
//  SupervisorFieldWorkorderdetail.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorFieldWorkorderdetail: UIViewController {
    
    var det = [fwkdetails]()
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    @IBOutlet weak var detailView: UIView!
    
    
    @IBOutlet weak var wkordertoken: UILabel!
    @IBOutlet weak var Projectlab: UILabel!
    @IBOutlet weak var Clientlab: UILabel!
    @IBOutlet weak var clientreflab: UILabel!
    @IBOutlet weak var localtionlab: UILabel!
    @IBOutlet weak var worktypelab: UILabel!
    @IBOutlet weak var descriptionlab: UILabel!
    @IBOutlet weak var skilllab: UILabel!
    @IBOutlet weak var reportedbylab: UILabel!
    @IBOutlet weak var contactlab: UILabel!
    @IBOutlet weak var reportedonlab: UILabel!
    @IBOutlet weak var supervisorlab: UILabel!
    @IBOutlet weak var leadlab: UILabel!
    @IBOutlet weak var teamlab: UILabel!
    @IBOutlet weak var startdatelab: UILabel!
    @IBOutlet weak var enddatelab: UILabel!
    @IBOutlet weak var assetdescription: UILabel!
    
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey:"token_id")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        print("selected index = \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        case 0:
            detailView.alpha = 1
            print("first item")
        case 1:
            detailView.alpha = 0
         
            print("second item")
        case 2:
            detailView.alpha = 0
            
            print("Third item")
        default:
            print("default item")
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadItems()
        sgTextOnlyBar.selectorType = .bottomBar
        sgTextOnlyBar.SelectedFont = UIFont(name: "ChalkboardSE-Bold", size: 15)!
        sgTextOnlyBar.normalFont = UIFont(name: "ChalkboardSE-Regular", size: 15)!
      
        // Do any additional setup after loading the view.
    }
    

    func downloadItems() {
        guard let token = UserDefaults.standard.value(forKey: "token_id") as? String else {return}
        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_supervisordetails_retrieve.php")! as URL)
               request.httpMethod = "POST"
               let postString = "token_id=\(token)"
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
               print("The count is \(jsonResult.count)")
               jsonElement = jsonResult[i] as! NSDictionary
                   //the following insures none of the JsonElement values are nil through optional binding
               let wkordertoken = jsonElement["work_type_token"] as? String
               let client = jsonElement["client_name"] as? String
               let sdateTime = jsonElement["date_time"] as? String
               let edateTime = jsonElement["date_time"] as? String
               let clientref = jsonElement["client_ref_id"] as? String
               let location = jsonElement["location"] as? String
               let worktype = jsonElement["work_type"] as? String
               let project = jsonElement["work_type"] as? String
               let clientcontact = jsonElement["client_contact"] as? String
               let description = jsonElement["description"] as? String
               let leadname = jsonElement["lead_name"] as? String
               let reportedby = jsonElement["reported_by"] as? String
               let reportedOn = jsonElement["reported_by"] as? String
               let assetdesc = jsonElement["asset_description"] as? String
            let skill = jsonElement["title"] as? String
            let supervisor = jsonElement["supervisor_name"] as? String
            
            det.append(fwkdetails(proj: project, clientname: client, clientreflab: clientref, location: location, wktype: worktype, desc: description!, skill: skill, reportedby: reportedby, contact: clientcontact, reportedon: reportedOn, supervisor: supervisor, lead: leadname, starteddate: sdateTime, endate: edateTime, asset: assetdesc, wkordertoken: wkordertoken))
             
                
                   
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
  
            for i in det{
                
                self.Projectlab.text = i.proj
                self.Clientlab.text = i.clientname
                self.clientreflab.text = i.clientreflab
                self.localtionlab.text = i.location
                self.worktypelab.text = i.wktype
                self.descriptionlab.text = i.desc
                self.skilllab.text = i.skill
                self.reportedbylab.text = i.reportedby
                self.contactlab.text = i.contact
                self.reportedonlab.text = i.starteddate
                self.supervisorlab.text = i.supervisor
                self.leadlab.text =  i.lead
                self.startdatelab.text = i.starteddate
                self.enddatelab.text = i.endate
                self.assetdescription.text = i.asset
                self.wkordertoken.text = i.wkordertoken
                
                
            }
           })
           }

}
struct fwkdetails{
    
    var proj: String?
    var clientname: String?
    var clientreflab: String?
    var location: String?
    var wktype: String?
    var desc:String?
    var skill: String?
    var reportedby: String?
    var contact:String?
    var reportedon: String?
    var supervisor: String?
    var lead: String?
    var starteddate: String?
    var endate: String?
    var asset: String?
    var wkordertoken: String?
    
    
    
    
}
