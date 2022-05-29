//
//  APIHandler.swift
//  Employees
//
//  Created by Anilkumar PS  on 27/05/22.
//

import Foundation


class APIHandler
{
    static let shared = APIHandler()
    
    func getEmployeeData(completion: @escaping (() ->Void))
    {
        var req = URLRequest(url: URL(string: AppConstants.sharedAC.URL)!)
        req.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: req, completionHandler: { data, response, error -> Void in
            
            print(response)
            do
            {
               // let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let model = try JSONDecoder().decode([Employees].self, from: data!)
                model.forEach { $0.storeData()}
                completion()
            }
            catch
            {
                print(error.localizedDescription)
                completion()
            }
            
        })
        task.resume()
    }
}

public struct APIResponse<T: Codable>: Codable
{
    public let data:T
}
