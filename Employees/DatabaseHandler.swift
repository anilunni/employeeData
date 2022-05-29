//
//  DatabaseHandler.swift
//  Employees
//
//  Created by Anilkumar PS  on 27/05/22.
//

import UIKit
import CoreData

class DatabaseHandler {


    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    func addToDB<T: NSManagedObject>(_ type: T.Type) -> T?
    {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func fetchData<T: NSManagedObject>(_ type: T.Type) -> [T]
    {
        let request = T.fetchRequest()
        do{
            let result = try viewContext.fetch(request)
            return result as! [T]
        }
        catch
        {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveToDB()
    {
        do{
            try viewContext.save()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}
