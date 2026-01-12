// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'home.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage>
//     with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // حركة الدوران
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//
//     // الانتقال لصفحة الشات
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const Home()),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF343541),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RotationTransition(
//               turns: _controller,
//               child: const Icon(
//                 Icons.mark_chat_read,
//                 size: 80,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "ChatGPT",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "جارٍ التحميل...",
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String dots = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // حركة النقاط
    timer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      setState(() {
        dots = dots.length < 3 ? "$dots." : "";
      });
    });

    // الانتقال لصفحة الشات
    Future.delayed(const Duration(seconds: 3), () {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "ChatGPT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Loading$dots",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}