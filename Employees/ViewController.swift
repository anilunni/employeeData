//
//  ViewController.swift
//  Employees
//
//  Created by Anilkumar PS  on 27/05/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var employeeTbl: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var employees: [EmployeeList] = []
    var currentEmployeeArr: [EmployeeList] = []
    var employee = EmployeeList()
    {
        didSet
        {
            self.employeeTbl.reloadData()
        }
    }
    
    var dbHandler = DatabaseHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIHandler.shared.getEmployeeData
        {
            DispatchQueue.main.async {
                self.employees = self.dbHandler.fetchData(EmployeeList.self)
                self.currentEmployeeArr = self.employees
                self.employeeTbl.reloadData()
            }
            
        }
        // Do any additional setup after loading the view.
    }
 func onSave()
 {
    guard let user = dbHandler.addToDB(EmployeeList.self) else { return  }
    user.username = "u_name"
    user.name = "name"
    dbHandler.saveToDB()
 }
    func naviagtionToDetails()
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "employeevc") as! EmployeeDetailsVC
        vc.employeeData = self.employee
        self.navigationController?.pushViewController(vc, animated: false)
        self.present(vc, animated: false, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell  = tableView.dequeueReusableCell(withIdentifier: "employeecell", for: indexPath)
        let eCell = cell as! EmployeeCell
        eCell.nameLBL.text = employees[indexPath.row].name
        eCell.emailLBL.text = employees[indexPath.row].email
        guard let url = URL(string: employees[indexPath.row].profileImg ?? "") else { return eCell }
        eCell.profileImg.downloaded(from: url)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.employee = self.employees[indexPath.row]
        self.naviagtionToDetails()
    }
    
}

extension ViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty  else { employees = currentEmployeeArr; return }

            employees = currentEmployeeArr.filter({ employe -> Bool in
                return (employe.name!.lowercased().contains(searchText.lowercased()) || employe.email!.lowercased().contains(searchText.lowercased()))
            })
            employeeTbl.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
}
