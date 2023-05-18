//
//  PersonRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/28/19.
//

import NIO
import NIOHTTP1

public protocol PersonRoutes: StripeAPIRoute {
    /// Creates a new person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - address: The person’s address.
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - phone: The person’s phone number.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - addressKana: The Kana variation of the person’s address (Japan only).
    ///   - addressKanji: The Kanji variation of the person’s address (Japan only).
    ///   - documents: Documents that may be submitted to satisfy various informational requests.
    ///   - firstNameKana: The Kana variation of the person’s first name (Japan only).
    ///   - firstNameKanji: The Kanji variation of the person’s first name (Japan only).
    ///   - fullNameAliases: A list of alternate names or aliases that the person is known by.
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumberSecondary: The person’s secondary ID number, as appropriate for their country, will be used for enhanced verification checks. In Thailand, this would be the laser code found on the back of an ID card. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastNameKana: The Kana variation of the person’s last name (Japan only).
    ///   - lastNameKanji: The Kanji variation of the person’s last name (Japan only)
    ///   - maidenName: The person’s maiden name.
    ///   - nationality: The country where the person is a national. Two-letter country code (ISO 3166-1 alpha-2), or “XX” if unavailable.
    ///   - personToken: A person token, used to securely provide details to the person.
    ///   - politicalExposure: Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    ///   - registeredAddress: The person’s registered address.
    ///   - verification: The person’s verification status.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a person object.
    func create(account: String,
                address: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                idNumber: String?,
                lastName: String?,
                metadata: [String: String]?,
                phone: String?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                addressKana: [String: Any]?,
                addressKanji: [String: Any]?,
                documents: [String: Any]?,
                firstNameKana: String?,
                firstNameKanji: String?,
                fullNameAliases: [String]?,
                gender: PersonGender?,
                idNumberSecondary: String?,
                lastNameKana: String?,
                lastNameKanji: String?,
                maidenName: String?,
                nationality: String?,
                personToken: String?,
                politicalExposure: PersonPoliticalExposure?,
                registeredAddress: [String: Any]?,
                verification: [String: Any]?,
                expand: [String]?) async throws -> Person
    
    /// Retrieves an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a person object.
    func retrieve(account: String, person: String, expand: [String]?) async throws -> Person
    
    /// Updates an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    ///   - address: The person’s address.
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - phone: The person’s phone number.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - addressKana: The Kana variation of the person’s address (Japan only).
    ///   - addressKanji: The Kanji variation of the person’s address (Japan only).
    ///   - documents: Documents that may be submitted to satisfy various informational requests.
    ///   - firstNameKana: The Kana variation of the person’s first name (Japan only).
    ///   - firstNameKanji: The Kanji variation of the person’s first name (Japan only).
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumberSecondary: The person’s secondary ID number, as appropriate for their country, will be used for enhanced verification checks. In Thailand, this would be the laser code found on the back of an ID card. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastNameKana: The Kana variation of the person’s last name (Japan only).
    ///   - lastNameKanji: The Kanji variation of the person’s last name (Japan only)
    ///   - maidenName: The person’s maiden name.
    ///   - nationality: The country where the person is a national. Two-letter country code (ISO 3166-1 alpha-2), or “XX” if unavailable.
    ///   - personToken: A person token, used to securely provide details to the person.
    ///   - politicalExposure: Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    ///   - registeredAddress: The person’s registered address.
    ///   - verification: The person’s verification status.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a person object.
    func update(account: String,
                person: String,
                address: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                idNumber: String?,
                lastName: String?,
                metadata: [String: String]?,
                phone: String?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                addressKana: [String: Any]?,
                addressKanji: [String: Any]?,
                documents: [String: Any]?,
                firstNameKana: String?,
                firstNameKanji: String?,
                gender: PersonGender?,
                idNumberSecondary: String?,
                lastNameKana: String?,
                lastNameKanji: String?,
                maidenName: String?,
                nationality: String?,
                personToken: String?,
                politicalExposure: PersonPoliticalExposure?,
                registeredAddress: [String: Any]?,
                verification: [String: Any]?,
                expand: [String]?) async throws -> Person
    
    /// Deletes an existing person’s relationship to the account’s legal entity. Any person with a relationship for an account can be deleted through the API, except if the person is the `account_opener`. If your integration is using the `executive` parameter, you cannot delete the only verified `executive` on file.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    /// - Returns: Returns the deleted person object.
    func delete(account: String, person: String) async throws -> DeletedObject
    
    /// Returns a list of people associated with the account’s legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/persons/list?&lang=curl)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` people, starting after person `starting_after`. Each entry in the array is a separate person object. If no more people are available, the resulting array will be empty.
    func listAll(account: String, filter: [String: Any]?) async throws -> PersonsList
}

public struct StripePersonRoutes: PersonRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let persons = APIBase + APIVersion + "accounts"
    
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(account: String,
                       address: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       metadata: [String: String]? = nil,
                       phone: String? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String? = nil,
                       addressKana: [String: Any]? = nil,
                       addressKanji: [String: Any]? = nil,
                       documents: [String: Any]? = nil,
                       firstNameKana: String? = nil,
                       firstNameKanji: String? = nil,
                       fullNameAliases: [String]? = nil,
                       gender: PersonGender? = nil,
                       idNumberSecondary: String? = nil,
                       lastNameKana: String? = nil,
                       lastNameKanji: String? = nil,
                       maidenName: String? = nil,
                       nationality: String? = nil,
                       personToken: String? = nil,
                       politicalExposure: PersonPoliticalExposure? = nil,
                       registeredAddress: [String: Any]? = nil,
                       verification: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Person {
        var body: [String: Any] = [:]
        
        if let address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email {
            body["email"] = email
        }
        
        if let firstName {
            body["first_name"] = firstName
        }
        
        if let idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName {
            body["last_name"] = lastName
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phone {
            body["phone"] = phone
        }
                                                                                            
        if let relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let addressKana {
            addressKana.forEach { body["address_kana[\($0)]"] = $1 }
        }
        
        if let addressKanji {
            addressKanji.forEach { body["address_kanji[\($0)]"] = $1 }
        }
        
        if let documents {
            documents.forEach { body["documents[\($0)]"] = $1 }
        }
        
        if let firstNameKana {
            body["first_name_kana"] = firstNameKana
        }
        
        if let firstNameKanji {
            body["first_name_kanji"] = firstNameKanji
        }
        
        if let gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumberSecondary {
            body["id_number_secondary"] = idNumberSecondary
        }
        
        if let lastNameKana {
            body["last_name_kana"] = lastNameKana
        }
        
        if let lastNameKanji {
            body["last_name_kanji"] = lastNameKanji
        }
        
        if let maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let nationality {
            body["nationality"] = nationality
        }
        
        if let personToken {
            body["person_token"] = personToken
        }
        
        if let politicalExposure {
            body["political_exposure"] = politicalExposure.rawValue
        }
        
        if let registeredAddress {
            registeredAddress.forEach { body["registered_address[\($0)]"] = $1 }
        }
       
        if let verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(persons)/\(account)/persons", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(account: String, person: String, expand: [String]? = nil) async throws -> Person {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .GET, path: "\(persons)/\(account)/persons/\(person)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(account: String,
                       person: String,
                       address: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       metadata: [String: String]? = nil,
                       phone: String? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String? = nil,
                       addressKana: [String: Any]? = nil,
                       addressKanji: [String: Any]? = nil,
                       documents: [String: Any]? = nil,
                       firstNameKana: String? = nil,
                       firstNameKanji: String? = nil,
                       gender: PersonGender? = nil,
                       idNumberSecondary: String? = nil,
                       lastNameKana: String? = nil,
                       lastNameKanji: String? = nil,
                       maidenName: String? = nil,
                       nationality: String? = nil,
                       personToken: String? = nil,
                       politicalExposure: PersonPoliticalExposure? = nil,
                       registeredAddress: [String: Any]? = nil,
                       verification: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Person {
        var body: [String: Any] = [:]
        
        if let address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email {
            body["email"] = email
        }
        
        if let firstName {
            body["first_name"] = firstName
        }
        
        if let idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName {
            body["last_name"] = lastName
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phone {
            body["phone"] = phone
        }
                                                                                            
        if let relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let addressKana {
            addressKana.forEach { body["address_kana[\($0)]"] = $1 }
        }
        
        if let addressKanji {
            addressKanji.forEach { body["address_kanji[\($0)]"] = $1 }
        }
        
        if let documents {
            documents.forEach { body["documents[\($0)]"] = $1 }
        }
        
        if let firstNameKana {
            body["first_name_kana"] = firstNameKana
        }
        
        if let firstNameKanji {
            body["first_name_kanji"] = firstNameKanji
        }
        
        if let gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumberSecondary {
            body["id_number_secondary"] = idNumberSecondary
        }
        
        if let lastNameKana {
            body["last_name_kana"] = lastNameKana
        }
        
        if let lastNameKanji {
            body["last_name_kanji"] = lastNameKanji
        }
        
        if let maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let nationality {
            body["nationality"] = nationality
        }
        
        if let personToken {
            body["person_token"] = personToken
        }
        
        if let politicalExposure {
            body["political_exposure"] = politicalExposure.rawValue
        }
        
        if let registeredAddress {
            registeredAddress.forEach { body["registered_address[\($0)]"] = $1 }
        }
       
        if let verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(persons)/\(account)/persons/\(person)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(account: String, person: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(persons)/\(account)/persons/\(person)", headers: headers)
    }
    
    public func listAll(account: String, filter: [String: Any]? = nil) async throws -> PersonsList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(persons)/\(account)/persons", query: queryParams, headers: headers)
    }
}
