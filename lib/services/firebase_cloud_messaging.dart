import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();

    //getting the fcm token
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.data['type'] == 'order') {
      //print('Navigate the user to the orders page');
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  Future<RemoteMessage?> getMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    return initialMessage;
  }
}
