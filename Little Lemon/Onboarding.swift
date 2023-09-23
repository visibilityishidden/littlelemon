//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Yaroslav Liashevych on 22.09.2023.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"


struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn,
                    label: {
                        EmptyView() // Return an EmptyView
                    }
                )
                Group {
                    TextField(
                        "First Name",
                        text: $firstName
                    )
                    TextField(
                        "Last Name",
                        text: $lastName
                    )
                    TextField(
                        "Email",
                        text: $email
                    )
                    .textInputAutocapitalization(.never)
                }
                .padding(4)
                .textFieldStyle(OutlinedTextFieldStyle())
                Button {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, isValidEmail(email) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true 
                    }
                } label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 40)
                        .background(.yellow)
                        .cornerRadius(12)
                }
                
            }
            .padding(16)
            .onAppear {
                if (UserDefaults.standard.bool(forKey: kIsLoggedIn) == true) {
                    isLoggedIn = true
                }
            }
        }
    }
}

//MARK: - Validating email
extension Onboarding {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

//MARK: - TextField styling
struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
