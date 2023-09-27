// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Contributors extends StatelessWidget {
//   Future<List> getContributors() async {
//     var response = await http.get(
//       Uri.parse(githubLink),
//       headers: {
//         'Authorization': '',
//       },
//     );
//     var decodedResponse = json.decode(response.body);
//     return decodedResponse;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Contributors",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: FutureBuilder(
//         future: getContributors(),
//         builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: SpinKitFadingCircle(
//                 color: const Color(0xFF006aff),
//                 size: 45.0,
//                 duration: Duration(milliseconds: 900),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             print(snapshot.data);
//             snapshot.data?.removeWhere((element) => element["id"] == 98887175);
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 itemCount: snapshot.data?.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 itemBuilder: (_, index) {
//                   return InkWell(
//                     onTap: () {
//                       launchUrl(Uri.parse(snapshot.data?[index]['html_url']));
//                     },
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CircleAvatar(
//                               radius: 50,
//                               backgroundColor: Colors.grey,
//                               backgroundImage:
//                                   snapshot.data?[index]['avatar_url'] != null
//                                       ? NetworkImage(
//                                           snapshot.data?[index]['avatar_url'])
//                                       : null,
//                             ),
//                             Text(
//                               snapshot.data?[index]['login'],
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else {
//             return Center(
//               child: Text("Check your internet connection"),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
