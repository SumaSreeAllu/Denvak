import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart'; // Import your login page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with error handling
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "your_app_id_here", // Replace with your actual Web API key
        authDomain: "denvak-9ed16.firebaseapp.com", // Auth domain from Firebase
        projectId: "denvak-9ed16", // Your Project ID
        storageBucket: "denvak-9ed16.appspot.com", // Storage bucket name
        messagingSenderId: "729390758374", // Messaging sender ID
        appId: "your_app_id_here", // Your app's App ID
      ),
    );
  } catch (e) {
    // Handle Firebase initialization errors
    print("Firebase initialization failed: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home:
          const InitializationWrapper(), // Start with the initialization wrapper
    );
  }
}

// This widget shows a loading indicator until Firebase is initialized
class InitializationWrapper extends StatelessWidget {
  const InitializationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check if Firebase is successfully initialized
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage(); // Navigate to login page
        }

        // Display loading indicator while Firebase is initializing
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If Firebase initialization fails, show an error message
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error initializing Firebase: ${snapshot.error}"),
            ),
          );
        }

        // Fallback to loading indicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
