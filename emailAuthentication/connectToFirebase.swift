// add following code to main AppDelegate.swift class.
// Connects to Firebase when app starts.
// Code from Firebase documentation.

import Firebase

func application(_ application: UIApplication, 
                    didFinishLaunchingWithOptions launchOptions:
                    [UIApplicationLaunchOptionsKey: Any]?) -> {

        FirebaseApp.configure()
        return true
    }
