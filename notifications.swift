import UserNotifications

// In order to see this notification, you will need to run the app and then background the app immediately

let userNotificationCenter = UNUserNotificationCenter.current()

// asking for permissions
func requestNotificationAuthorization(){
  let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)

  self.userNotificationCenter.requestAuthorization(options: authOptions) {(success, error) in
    if let error = error {
      print("Error: ", error);
    }
  }
}

func sendNotification(){
  // new notification instance
  let notificationContent = UNMutableNotificationContent()

  // replace quotes with relevant information!!!!!!!
  notificationContent.title = "Title"
  notificationContent.body = "Body"
  notificationContent.badge = NSNumber(value: 3) // what does this do

  // do we need to add an attachment to the notification content??
  if let url = Bundle.main.url(forResource: "dune", withExtension: "png"){
    if attachment = try? UNNotificationAttachment(identifier: "dune", url: url, options: nil){
    notificationContent.attachments = [attachment]
    }
  }

  // creating a trigger
  // understand parameters
  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

  let request = UNNotificationRequest(identifier: "Test", content: notificationContent, trigger: trigger)

  userNotificationCenter.add(request){ (error) in
    if let error = error {
      print("Notification Error: ", error)
    }
  }
}

override func viewDidLoad(){
  super.viewDidLoad()
  self.requestNotificationAuthorization()
  self.sendNotification()
}

// change parameters
// When your app is in the background and the notification gets displayed. If you tap the notification
// this method will be called. From here you can access the information of the notification via the notification argument.

func application(application: UIApplication, didReceive notification: UILocalNotification){
  UIApplication.shared.applicationIconBadgeNumber = 0
