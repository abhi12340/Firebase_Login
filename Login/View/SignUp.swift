//
//  SignUp.swift
//  Login
//
//  Created by Abhishek Kumar on 05/01/21.
//

import SwiftUI
import FirebaseAuth

struct SignUp : View {
    
    @State var color = Color.white.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @State var visible = false
    @State var reVisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack {
            ZStack(alignment:.topLeading) {
                GeometryReader { _ in
                    VStack() {
                        Text("Register")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 35)
                        
                        CustomTextField(placeholder: Text("email").foregroundColor(.white), text: self.$email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(self.email != "" ? Color(.red) : .white ,lineWidth: 1))
                            .padding(.top,25)
                            .foregroundColor(.white)
                        HStack(spacing : 15) {
                            VStack {
                                if self.visible == true {
                                    CustomTextField(placeholder: Text("password").foregroundColor(.white), text: self.$password)
                                } else {
                                    SecureField("Password", text: self.$password).foregroundColor(.white)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }, label : {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(.white)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(self.password != "" ? Color(.red) : self.color,lineWidth: 1))
                        .padding(.top , 25)
                        
                
                        HStack(spacing : 15) {
                            VStack {
                                if self.reVisible == true {
                                    CustomTextField(placeholder: Text("re-enter password").foregroundColor(.white), text: self.$password)
                                } else {
                                    SecureField("re-enter password", text: self.$rePassword).foregroundColor(.white)
                                }
                            }
                            Button(action: {
                                self.reVisible.toggle()
                            }, label : {
                                Image(systemName: self.reVisible ? "eye.slash.fill" : "eye.fill").foregroundColor(.white)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(self.rePassword != "" ? Color(.red) : self.color,lineWidth: 1))
                        .padding(.top , 25)
                        
                        Button {
                            self.register()
                        } label: {
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color(red: 255 / 255, green: 165 / 255, blue: 0 / 255))
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                    }
                    .padding(.horizontal , 25)
                    .padding(.top , 100)
                }
                
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.top , 20)
            }
            if self.alert {
                ErrorView(error: self.$error, alert: self.$alert)
            }
        }
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 75 / 255, green: 0 / 255, blue: 130 / 255), Color(red: 218 / 255, green: 112 / 255, blue: 114 / 255),.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea(.all)
    }
    
    func register() {
        if self.email != "" {
            if password == rePassword {
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil {
                        self.error = error?.localizedDescription ?? "Register error"
                        self.alert.toggle()
                        return
                    }
                    print("User Successfull created")
                    UserDefaults.standard.setValue(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            } else {
                self.error = "Entered password did not matched"
                self.alert.toggle()
            }
        } else {
            self.error = "Fields are blank"
            self.alert.toggle()
        }
    }
}
