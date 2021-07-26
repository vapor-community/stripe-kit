//
//  PersonRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/28/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol PersonRoutes {
    /// Creates a new person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - address: The person’s address.
    ///   - addressKana: The Kana variation of the person’s address (Japan only).
    ///   - addressKanji: The Kanji variation of the person’s address (Japan only).
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - firstNameKana: The Kana variation of the person’s first name (Japan only).
    ///   - firstNameKanji: The Kanji variation of the person’s first name (Japan only).
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - lastNameKana: The Kana variation of the person’s last name (Japan only).
    ///   - lastNameKanji: The Kanji variation of the person’s last name (Japan only)
    ///   - maidenName: The person’s maiden name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - nationality: The country where the person is a national. Two-letter country code (ISO 3166-1 alpha-2), or “XX” if unavailable.
    ///   - personToken: A person token, used to securely provide details to the person.
    ///   - phone: The person’s phone number.
    ///   - politicalExposure: Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - verification: The person’s verification status.
    /// - Returns: Returns a person object.
    func create(account: String,
                address: [String: Any]?,
                addressKana: [String: Any]?,
                addressKanji: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                firstNameKana: String?,
                firstNameKanji: String?,
                gender: StripePersonGender?,
                idNumber: String?,
                lastName: String?,
                lastNameKana: String?,
                lastNameKanji: String?,
                maidenName: String?,
                metadata: [String: String]?,
                nationality: String?,
                personToken: String?,
                phone: String?,
                politicalExposure: StripePersonPoliticalExposure?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                verification: [String: Any]?,
                context: LoggingContext) -> EventLoopFuture<StripePerson>
    
    /// Retrieves an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to retrieve.
    /// - Returns: Returns a person object.
    func retrieve(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripePerson>
    
    /// Updates an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    ///   - address: The person’s address.
    ///   - addressKana: The Kana variation of the person’s address (Japan only).
    ///   - addressKanji: The Kanji variation of the person’s address (Japan only).
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - firstNameKana: The Kana variation of the person’s first name (Japan only).
    ///   - firstNameKanji: The Kanji variation of the person’s first name (Japan only).
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - lastNameKana: The Kana variation of the person’s last name (Japan only).
    ///   - lastNameKanji: The Kanji variation of the person’s last name (Japan only)
    ///   - maidenName: The person’s maiden name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - nationality: The country where the person is a national. Two-letter country code (ISO 3166-1 alpha-2), or “XX” if unavailable.
    ///   - personToken: A person token, used to securely provide details to the person.
    ///   - phone: The person’s phone number.
    ///   - politicalExposure: Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - verification: The person’s verification status.
    /// - Returns: Returns a person object.
    func update(account: String,
                person: String,
                address: [String: Any]?,
                addressKana: [String: Any]?,
                addressKanji: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                firstNameKana: String?,
                firstNameKanji: String?,
                gender: StripePersonGender?,
                idNumber: String?,
                lastName: String?,
                lastNameKana: String?,
                lastNameKanji: String?,
                maidenName: String?,
                metadata: [String: String]?,
                nationality: String?,
                personToken: String?,
                phone: String?,
                politicalExposure: StripePersonPoliticalExposure?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                verification: [String: Any]?,
                context: LoggingContext) -> EventLoopFuture<StripePerson>
    
    /// Deletes an existing person’s relationship to the account’s legal entity.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    /// - Returns: Returns the deleted person object.
    func delete(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of people associated with the account’s legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/persons/list?&lang=curl)
    /// - Returns: A `StripePersonsList`
    func listAll(account: String, filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripePersonsList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PersonRoutes {
    public func create(account: String,
                       address: [String: Any]? = nil,
                       addressKana: [String: Any]? = nil,
                       addressKanji: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       firstNameKana: String? = nil,
                       firstNameKanji: String? = nil,
                       gender: StripePersonGender? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       lastNameKana: String? = nil,
                       lastNameKanji: String? = nil,
                       maidenName: String? = nil,
                       metadata: [String: String]? = nil,
                       nationality: String? = nil,
                       personToken: String? = nil,
                       phone: String? = nil,
                       politicalExposure: StripePersonPoliticalExposure? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String?,
                       verification: [String: Any]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripePerson> {
        return create(account: account,
                      address: address,
                      addressKana: addressKana,
                      addressKanji: addressKanji,
                      dob: dob,
                      email: email,
                      firstName: firstName,
                      firstNameKana: firstName,
                      firstNameKanji: firstNameKanji,
                      gender: gender,
                      idNumber: idNumber,
                      lastName: lastName,
                      lastNameKana: lastNameKana,
                      lastNameKanji: lastNameKanji,
                      maidenName: maidenName,
                      metadata: metadata,
                      nationality: nationality,
                      personToken: personToken,
                      phone: phone,
                      politicalExposure: politicalExposure,
                      relationship: relationship,
                      ssnLast4: ssnLast4,
                      verification: verification)
    }
    
    public func retrieve(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripePerson> {
        return retrieve(account: account, person: person)
    }
    
    public func update(account: String,
                       person: String,
                       address: [String: Any]? = nil,
                       addressKana: [String: Any]? = nil,
                       addressKanji: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       firstNameKana: String? = nil,
                       firstNameKanji: String? = nil,
                       gender: StripePersonGender? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       lastNameKana: String? = nil,
                       lastNameKanji: String? = nil,
                       maidenName: String? = nil,
                       metadata: [String: String]? = nil,
                       nationality: String? = nil,
                       personToken: String? = nil,
                       phone: String? = nil,
                       politicalExposure: StripePersonPoliticalExposure? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String? = nil,
                       verification: [String: Any]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripePerson> {
        return update(account: account,
                      person: person,
                      address: address,
                      addressKana: addressKana,
                      addressKanji: addressKanji,
                      dob: dob,
                      email: email,
                      firstName: firstName,
                      firstNameKana: firstName,
                      firstNameKanji: firstNameKanji,
                      gender: gender,
                      idNumber: idNumber,
                      lastName: lastName,
                      lastNameKana: lastNameKana,
                      lastNameKanji: lastNameKanji,
                      maidenName: maidenName,
                      metadata: metadata,
                      nationality: nationality,
                      personToken: personToken,
                      phone: phone,
                      politicalExposure: politicalExposure,
                      relationship: relationship,
                      ssnLast4: ssnLast4,
                      verification: verification)
    }
    
    public func delete(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject> {
        return delete(account: account, person: person)
    }
    
    public func listAll(account: String, filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripePersonsList> {
        return listAll(account: account, filter: filter)
    }
}

public struct StripePersonRoutes: PersonRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let persons = APIBase + APIVersion + "accounts"
    
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(account: String,
                       address: [String: Any]?,
                       addressKana: [String: Any]?,
                       addressKanji: [String: Any]?,
                       dob: [String: Any]?,
                       email: String?,
                       firstName: String?,
                       firstNameKana: String?,
                       firstNameKanji: String?,
                       gender: StripePersonGender?,
                       idNumber: String?,
                       lastName: String?,
                       lastNameKana: String?,
                       lastNameKanji: String?,
                       maidenName: String?,
                       metadata: [String: String]?,
                       nationality: String?,
                       personToken: String?,
                       phone: String?,
                       politicalExposure: StripePersonPoliticalExposure?,
                       relationship: [String: Any]?,
                       ssnLast4: String?,
                       verification: [String: Any]?,
                       context: LoggingContext) -> EventLoopFuture<StripePerson> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let addressKana = addressKana {
            addressKana.forEach { body["address_kana[\($0)]"] = $1 }
        }
        
        if let addressKanji = addressKanji {
            addressKanji.forEach { body["address_kanji[\($0)]"] = $1 }
        }
        
        if let dob = dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let firstName = firstName {
            body["first_name"] = firstName
        }
        
        if let firstNameKana = firstNameKana {
            body["first_name_kana"] = firstNameKana
        }
        
        if let firstNameKanji = firstNameKanji {
            body["first_name_kanji"] = firstNameKanji
        }
        
        if let gender = gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumber = idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName = lastName {
            body["last_name"] = lastName
        }
        
        if let lastNameKana = lastNameKana {
            body["last_name_kana"] = lastNameKana
        }
        
        if let lastNameKanji = lastNameKanji {
            body["last_name_kanji"] = lastNameKanji
        }
        
        if let maidenName = maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let nationality = nationality {
            body["nationality"] = nationality
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let personToken = personToken {
            body["person_token"] = personToken
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let politicalExposure = politicalExposure {
            body["political_exposure"] = politicalExposure.rawValue
        }
        
        if let relationship = relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 = ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let verification = verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(persons)/\(account)/persons", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripePerson> {
        return apiHandler.send(method: .GET, path: "\(persons)/\(account)/persons/\(person)", headers: headers)
    }
    
    public func update(account: String,
                       person: String,
                       address: [String: Any]?,
                       addressKana: [String: Any]?,
                       addressKanji: [String: Any]?,
                       dob: [String: Any]?,
                       email: String?,
                       firstName: String?,
                       firstNameKana: String?,
                       firstNameKanji: String?,
                       gender: StripePersonGender?,
                       idNumber: String?,
                       lastName: String?,
                       lastNameKana: String?,
                       lastNameKanji: String?,
                       maidenName: String?,
                       metadata: [String: String]?,
                       nationality: String?,
                       personToken: String?,
                       phone: String?,
                       politicalExposure: StripePersonPoliticalExposure?,
                       relationship: [String: Any]?,
                       ssnLast4: String?,
                       verification: [String: Any]?,
                       context: LoggingContext) -> EventLoopFuture<StripePerson> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let addressKana = addressKana {
            addressKana.forEach { body["address_kana[\($0)]"] = $1 }
        }
        
        if let addressKanji = addressKanji {
            addressKanji.forEach { body["address_kanji[\($0)]"] = $1 }
        }
        
        if let dob = dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let firstName = firstName {
            body["first_name"] = firstName
        }
        
        if let firstNameKana = firstNameKana {
            body["first_name_kana"] = firstNameKana
        }
        
        if let firstNameKanji = firstNameKanji {
            body["first_name_kanji"] = firstNameKanji
        }
        
        if let gender = gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumber = idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName = lastName {
            body["last_name"] = lastName
        }
        
        if let lastNameKana = lastNameKana {
            body["last_name_kana"] = lastNameKana
        }
        
        if let lastNameKanji = lastNameKanji {
            body["last_name_kanji"] = lastNameKanji
        }
        
        if let maidenName = maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let nationality = nationality {
            body["nationality"] = nationality
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let personToken = personToken {
            body["person_token"] = personToken
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let politicalExposure = politicalExposure {
            body["political_exposure"] = politicalExposure.rawValue
        }
        
        if let relationship = relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 = ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let verification = verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(persons)/\(account)/persons/\(person)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(account: String, person: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(persons)/\(account)/persons/\(person)", headers: headers)
    }
    
    public func listAll(account: String, filter: [String : Any]?, context: LoggingContext) -> EventLoopFuture<StripePersonsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(persons)/\(account)/persons", query: queryParams, headers: headers)
    }
}
