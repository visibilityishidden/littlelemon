//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Yaroslav Liashevych on 22.09.2023.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName =  UserDefaults.standard.string(forKey: kFirstName)!
    @State private var lastName =  UserDefaults.standard.string(forKey: kLastName)!
    @State private var email =  UserDefaults.standard.string(forKey: kEmail)!
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Spacer()
            Text("Personal information")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            Text("Avatar")
                .foregroundColor(.gray)
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .leading)

            
            HStack {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(16)
                    .padding(.trailing, 32)
                //.frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    //
                } label: {
                    Text("Change")
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(12)
                }
                .padding(.trailing, 8)
                Button {
                    //
                } label: {
                    Text("Remove")
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .border(.black)
                }
                Spacer()
            }

            Spacer()
            Group {
//                Text(firstName ?? "")
//                Text(lastName ?? "")
//                Text(email ?? "")
                Text("First name")
                    .padding(.vertical, -8)
                    .foregroundColor(.gray)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Enter your first name", text: $firstName)
                Text("Last name")
                    .padding(.vertical, -8)
                    .foregroundColor(.gray)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Enter your last name", text: $lastName)
                Text("Email")
                    .padding(.vertical, -8)
                    .foregroundColor(.gray)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Enter your email", text: $email)
            }
            .textFieldStyle(OutlinedTextFieldStyle())
            .fontWeight(.bold)
            .padding(4)
            Spacer()
            Button {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .background(.red)
                    .cornerRadius(12)
            }
            HStack {
                Button {
                    //
                } label: {
                    Text("Discard changes")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .border(.black)
                        .cornerRadius(4)


                }
                Spacer()
                Button {
                    //
                } label: {
                    Text("Save changes")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 40)
            Spacer()
        }
        .padding()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
