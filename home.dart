// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.grey[900],
//     appBar: AppBar(
//       title: const Text("ChatGPT"),
//       backgroundColor: Colors.grey[850],
//     ),
//     body: const Center(
//       child: Text(
//         "واجهة الشات",
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  Color w = Colors.white;
  String getFakeReply(String userMessage) {
    if (userMessage.contains("مرحبا")) {
      return "مرحبًا بك! كيف أستطيع مساعدتك؟";
    } else if (userMessage.contains("اسمك")) {
      return "أنا ChatGPT، نموذج لغوي ذكي 🤖";
    } else if (userMessage.contains("شكرا")) {
      return "على الرحب والسعة 🌸";
    }
    else if (userMessage.contains("من مطورك")) {
      return " THE ENG : MOHAMMED TALAL ALGALAL";
    }else {
      return "هذا رد وهمي لأغراض العرض فقط 🙂";
    }
  }
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final userText = messageController.text;

    setState(() {
      messages.add({
        "text": userText,
        "isUser": true,
      });

      // رسالة "يكتب..."
      messages.add({
        "text": "ChatGPT يكتب...",
        "isUser": false,
        "typing": true,
      });

      messageController.clear();
    });

    scrollToBottom();

    // رد وهمي بعد ثانيتين
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages.removeWhere((m) => m["typing"] == true);

        messages.add({
          "text":getFakeReply(userText),
          "isUser": false,
        });
      });

      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text("ChatGPT"),
      ),
      drawer:
      Drawer(


        child:
        Container( color: Colors.grey, child: ListView(
          children:[
            TextField(decoration: InputDecoration(
              hintText: "بحث",

              filled: true,fillColor: Colors.white70, prefixIcon:
            Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,),),),

            ListTile( leading:
            IconButton(onPressed: (){
              setState(() {

              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("اكتب الاسم")));
            },
                icon: Icon(Icons.edit,color: Colors.red,)), title: Text("دردشة جديدة",
                style: TextStyle(color: Colors.white)), ),
            ListTile(leading: IconButton(icon:   Icon(Icons. image, color:w),
              onPressed: () {},),
              title:Text("المكتبة",style: TextStyle(color: w)),),
            ListTile(leading: IconButton(icon:   Icon(Icons. grid_view, color:w),
              onPressed: () {},),
              title: Text("نماذج GPT", style: TextStyle(color: w)),),
            ListTile(leading:IconButton(icon:   Icon(Icons. folder, color:w),
              onPressed: () {},),
              title: Text("مشروع جديد",
                  style: TextStyle(color: w)),),],),),),
      body: SafeArea(
        child: Column(
          children: [
            /// الرسائل
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {

                  final msg = messages[index];
                  if (msg["typing"] == true) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "ChatGPT يكتب...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return Align(
                    alignment: msg["isUser"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: msg["isUser"]
                            ? Colors.black
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        msg["text"],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// حقل الإدخال (ثابت بأسفل الشاشة)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.grey[850],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (_) => sendMessage(),
                      decoration: const InputDecoration(
                        hintText: "Ask ChatGPT",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}