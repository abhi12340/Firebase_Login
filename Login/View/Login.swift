//
//  Login.swift
//  Login
//
//  Created by Abhishek Kumar on 05/01/21.
//

import SwiftUI
import Firebase

struct Login : View {
    
    @State var color = Color.white.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack() {
            
            ZStack(alignment:.topTrailing) {
                GeometryReader() { _ in
                    VStack() {
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                          
                        
                        Text("Log in your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                            .padding(.top, 5)
                            
                        
                        CustomTextField(placeholder: Text("email").foregroundColor(.white), text: self.$email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(self.email != "" ? Color(.red) : self.color,lineWidth: 1))
                            .padding(.top,25)
                            .foregroundColor(.white)
                            
                        HStack(spacing : 15) {
                            VStack {
                                if self.visible == true {
                                    CustomTextField(placeholder: Text("password").foregroundColor(.white), text: self.$password)
                                } else {
                                    SecureField("Password", text: self.$password)
                                }
                            }
                            .foregroundColor(.white)
                            Button(action: {
                                self.visible.toggle()
                            }, label : {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(.white)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(self.password != "" ? Color(.red) : self.color,lineWidth: 1))
                        .padding(.top , 25)
                        
                        Button {
                            self.verify()
                        } label: {
                            Text("Login")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color(red: 255 / 255, green: 165 / 255, blue: 0 / 255))
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal , 25)
                    .padding(.top , 200)
                }
                Button {
                    self.show.toggle()
                    
                } label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.trailing)
                        .padding(.top,50)
                }

            }.background(LinearGradient(gradient: Gradient(colors: [Color(red: 75 / 255, green: 0 / 255, blue: 130 / 255), Color(red: 218 / 255, green: 112 / 255, blue: 114 / 255),.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea(.all)
            if self.alert {
                ErrorView(error: self.$error, alert: self.$alert)

            }
            
        }
    }
    
    func verify() {
        if !self.email.isEmpty && !self.password.isEmpty {
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, error) in
                guard let _ = res else {
                    self.error = error?.localizedDescription ?? "Login failed"
                    self.alert.toggle()
                  return
                }
                print("Sucess")
                UserDefaults.standard.setValue(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            self.error = "Please provide input in specific field"
            self.alert.toggle()
        }
    }
}


struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
