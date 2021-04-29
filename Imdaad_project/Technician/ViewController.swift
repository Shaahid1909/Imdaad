//
//  ViewController.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 22/04/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var vieww: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vieww.layer.cornerRadius = 2
        vieww.layer.shadowColor = UIColor.black.cgColor
        vieww.layer.shadowOffset = CGSize(width: 0.5, height: 5.0);
        vieww.layer.shadowOpacity = 0.6
        vieww.layer.shadowRadius = 6.0
        
        
        let emailImage = UIImage(named:"id")
        addLeftImageTo(txtField: txtEmail, andImage: emailImage!)
        
        let passwordImage = UIImage(named:"password")
        addLeftImageTo(txtField: txtPassword, andImage: passwordImage!)
        
   

    }
    
    
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }

    @IBAction func logBtnTapped(_ sender: UIButton) {
       self.showSpinner(onView: self.view)
        let parameters: Parameters = ["employee_id":txtEmail.text!,"password":txtPassword.text!]
         //   activityindicator.isHidden = false
         //   activityindicator.startAnimating()
           // print("checkuser : \(checkuser)")
            if txtEmail.text!.trimmingCharacters(in: .whitespaces).isEmpty && txtPassword.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                  }
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            self.removeSpinner()
            }else {
              AF.request("https://appstudio.co/iOS/imdaad_employee_login.php", method: .post, parameters: parameters).responseJSON
              {[self]Response in
                if let result = Response.value{
                  let jsonData = result as! NSDictionary
                  print("jsonData : \(jsonData.allValues)")
                  for i in jsonData.allValues{
                    if i as! String == "supervisor"{
                        if txtEmail.text == "1122"{
                       
                       //   userText.text = ""
                      //    passText.text = ""
                       //   activityindicator.stopAnimating()
                       //   activityindicator.isHidden = true
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "SupervisorView") as! SupervisorhomeView
                            
                                      // vc.pushViewController(vc, animated: true)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
               //--     vc.listnames = txtEmail.text
                        }
                        }else if i as! String == "technician"{
                         
                         // userText.text = ""
                         // passText.text = ""
                      //    activityindicator.stopAnimating()
                       //   activityindicator.isHidden = true
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let navigationController = storyBoard.instantiateViewController(withIdentifier: "SupervisorView") as! UINavigationController
                        let vc = storyBoard.instantiateViewController(withIdentifier: "TechView") as! TechnicianHomeVc
//                        navigationController.pushViewController(vc, animated: true)
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                            vc.emp_id = txtEmail.text
                            
                        
                    }else if i as! String == "failure"{
                   //   activityindicator.stopAnimating()
                 //     activityindicator.isHidden = true
                      let alert = UIAlertController(title: "Alert", message: "Check Username and Password", preferredStyle: UIAlertController.Style.alert)
                      let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        }
                      alert.addAction(cancel)
                      present(alert, animated: true, completion: nil)
                        self.removeSpinner()
                    }}}}}

    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

