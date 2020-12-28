//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

struct CredentialsObject {

    var jwt: String
    var email: String
    var password: String

    static let CREDENTIALS = "Credentials"

    private static let BLANK = "_"

    static var shared: CredentialsObject = {
        let base = CredentialsObject(jwt: BLANK, email: BLANK, password: BLANK)

        let managedContext = PersistenceController.shared.container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CredentialsObject.CREDENTIALS)

        do {
            let result = try managedContext.fetch(fetchRequest)

            if result.count == 0 {
                return base
            }

            guard let first = result.first as! NSManagedObject? else {
                return base
            }

            if let jwt = first.value(forKey: "jwt") as? String,
                let email = first.value(forKey: "email") as? String,
                let password = first.value(forKey: "password") as? String {
                return CredentialsObject(jwt: jwt, email: email, password: password)
            }

            return base
        } catch {

        }

        return base
    }()

    static func resetCredentials(jwt: String, email: String, password: String) -> Bool {
        // First clear the current credentials from Core Data
        deleteCurrentCredentials { (_) in }

        let cred = CredentialsObject(jwt: jwt, email: email, password: password)
        CredentialsObject.shared = cred

        let managedContext = PersistenceController.shared.container.viewContext

        let entity = NSEntityDescription.entity(forEntityName: CREDENTIALS, in: managedContext)!

        let newEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        newEntity.setValue(jwt, forKey: "jwt")
        newEntity.setValue(email, forKey: "email")
        newEntity.setValue(password, forKey: "password")

        do {
            try managedContext.save()

            return true
        } catch {

        }

        return false
    }

    static func deleteCurrentCredentials(completion: @escaping ((Bool) -> Void)) {
        CredentialsObject.shared = CredentialsObject(jwt: BLANK, email: BLANK, password: BLANK)

        let managedContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CredentialsObject.CREDENTIALS)

        do {
            let result = try managedContext.fetch(fetchRequest)
            for obj in result {
                managedContext.delete(obj as! NSManagedObject)
            }

            do {
                try managedContext.save()
                completion(true)
            } catch {
                completion(false)
            }

        } catch {
            completion(false)
        }
    }

    func isSet() -> Bool {
        return jwt != CredentialsObject.BLANK
            && email != CredentialsObject.BLANK
            && password != CredentialsObject.BLANK
    }

    func setUp() {

    }
}
