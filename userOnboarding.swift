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

        guard resule != nil, error == nil else {
            return
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
