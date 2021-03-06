import SwiftUI
import FirebaseAuth

// contains methods to login and logout using Firebase
class userOnboarding: ObservableObject {

    let auth = Auth.auth()

    // logged out by default
    var loggedIn = false
 
    // checks whether current user is logged in and returns Boolean
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }

    // function to handle login process.
    // takes in email and password (String format).
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in

        guard result != nil, error == nil else {
            return
        }
        // returning user signed in successfully
        self.loggedIn = true
        }
    }

    // function to create new user. 
    // takes in email and password (String format).
    func newUser(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in

        guard result != nil, error == nil else {
            return
        }
                                                               
        // sets values in action code settings struct
        let ActionCodeSettings = actionCodeSettings()
        ActionCodeSettings.handleCodeInApp = true
        ActionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

        // send email
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in

        // error checking
        if let error = error {
            self.showMessagePrompt("There was an error in sending the email. Please try again.")
            return
        }
        // Email sent successfully. Prompts user to check email. 
        UserDefaults.standard.set(email, forKey: "Email")
        self.showMessagePrompt("Check your GMU email to verify your identity.")

        // check that link was clicked + verify that it was the right one                                                                       
        if Auth.auth().isSignIn(withEmailLink: link) {

        Auth.auth().signIn(withEmail: email, link: self.link) { user, error in
            self.showMessagePrompt(error.localizedDescription)
            return
        }
    }
                                                                                                 
        // new user created successfully
        self.loggedIn = true
        }
    }

    // function to log out
    func logout() {
        try? auth.signOut()
        self.loggedIn = false
    }
}
