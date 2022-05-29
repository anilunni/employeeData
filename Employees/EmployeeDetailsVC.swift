//
//  EmployeeDetailsVC.swift
//  Employees
//
//  Created by Anilkumar PS  on 28/05/22.
//

import UIKit

class EmployeeDetailsVC: UIViewController {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var usernameLBL: UILabel!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var websiteLBL: UILabel!
    @IBOutlet weak var companyLBL: UILabel!
    
    
    var employeeData: EmployeeList!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let address = employeeData.address
        address
        self.nameLBL.text = employeeData.name
        self.usernameLBL.text = employeeData.username
        self.emailLBL.text = employeeData.email
        //self.addressLBL.text = employeeData.address as! String
        self.phoneLBL.text = employeeData.phone
        self.websiteLBL.text = employeeData.website
        guard let url = URL(string: employeeData.profileImg!) else { return  }
        self.profileImgView.downloaded(from: url)
       
        
    }

    @IBAction func backAction(_ sender: UIButton)
    {
        self.dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
