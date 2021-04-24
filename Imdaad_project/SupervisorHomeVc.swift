//
//  SupervisorHomeVc.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 23/04/21.
//

import UIKit

class SupervisorHomeVc: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBAction func exitBtn(_ sender: Any) {
        dismiss(animated: true)
        self.removeSpinner()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewLayout()
  
    }
    
    
    let homeItem: [data] = [data(title: "Workorders", image: "Workorders.png", detail: "24 Workorders"),
                            data(title: "Unassigned Workorders", image: "Unassigned.png",detail: "8 Workorders"),
                            data(title: "Field Completion", image: "Field Completion.png", detail: "45 Workorders"),
                            data(title: "Technicians", image: "Technicians.png", detail: "7 Technicians")]

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeItem.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! SupervisorhomeCollectionCell
        cell.iconImg.image = UIImage(named: "\(homeItem[indexPath.row].image)")
        cell.title.text = homeItem[indexPath.row].title
        cell.details.text = homeItem[indexPath.row].detail
        return cell
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 194, height: 198)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(homeItem[indexPath.row].title)
    }
 

}
struct data {
    let title: String
    let image: String
    let detail: String
}

