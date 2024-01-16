import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {

    // getting the initial message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming messages when the app is in the foreground
      //print("Message data: ${message.data}");
      if (message.notification != null) {
        //print('Message also contained a notification: ${message.notification?.body}');
      }

      handleRemoteMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the app is opened from a background state
      //print("Message data on open: ${message.data}");
      handleRemoteMessage( message);
    });

    //handling background messages
    FirebaseMessaging.onBackgroundMessage((message) => firebaseMessagingBackgroundHandler(message));

  }


  void handleRemoteMessage(RemoteMessage message) {
    if (message.data['type'] == 'order') {
      //print('Navigate the user to the orders page');
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    //print("Handling a background message: ${message.messageId}");
  }

  Future<RemoteMessage?> getMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    return initialMessage;
  }
}
