import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql/model/APIs/api_response.dart';
import 'package:graph_ql/view_model/controllers/graph_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final GraphController gController = Get.find();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            Obx(
              () => gController.apiResponse.value.status != Status.completed
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        gController.getData();
                      },
                      child: const Text('Get Data')),
            )
          ],
        ),
        body: Obx(() {
          var status = gController.apiResponse.value.status;
          if (status == Status.initial) {
            return Center(
              child: ElevatedButton(
                child: const Text("Fetch Data"),
                onPressed: () {
                  gController.getData();
                },
              ),
            );
          } else if (status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == Status.completed) {
            return ListView.builder(
                itemCount: gController.results.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title:
                          Text('User Id : ${gController.results[index]['id']}'),
                      subtitle: Text(
                        'First name  : ${gController.results[index]['firstName'] ?? 'No name'}',
                      ),
                    ),
                  );
                });
          } else if (status == Status.error) {
            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.face),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Something went wrong'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          gController.getData();
                        },
                        child: const Text('Fetch Again'))
                  ],
                ),
              ),
            );
          }
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  gController.getData();
                },
                child: const Text('Fetch Again')),
          );
        }));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<dynamic> characters = [];
//   bool _loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: _loading
//           ? const CircularProgressIndicator()
//           : characters.isEmpty
//               ? Center(
//                   child: ElevatedButton(
//                     child: const Text("Fetch Data"),
//                     onPressed: () {
//                       fetchData();
//                     },
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.builder(
//                       itemCount: characters.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(
//                               characters[index]['firstName'] ?? 'Null',
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//     );
//   }

//   void fetchData() async {
//     setState(() {
//       _loading = true;
//     });
//     HttpLink link = HttpLink(
//         "https://api.thegraph.com/subgraphs/name/dalhoum-ahmed/aurora-test-user-post-3");
//     GraphQLClient qlClient = GraphQLClient(
//       link: link,
//       cache: GraphQLCache(
//         store: HiveStore(),
//       ),
//     );
//     QueryResult queryResult = await qlClient.query(
//       QueryOptions(
//         document: gql(
//           """query {
// users {
// id
// userId
// firstName
// backgroundColor
// blockNumber
// instagram
// tags
// followedUsersCount
// followingUsersCount
// followedUsers
// followers

// }
// }""",
//         ),
//       ),
//     );

//     log('message');

//     setState(() {
//       characters = queryResult.data!['users'];
//       _loading = false;
//     });
//   }
// }
