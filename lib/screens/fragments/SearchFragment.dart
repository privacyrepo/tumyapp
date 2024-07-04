import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:tumy_app/screens/fragments/ProfileFragment.dart';
import 'package:tumy_app/screens/search/components/SearchCardComponent.dart';
import 'package:tumy_app/utils/Common.dart';

class SearchFragment extends StatefulWidget {
  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  List<SearchModel> list = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(svGetScaffoldColor());
    });
  }

Future<void> search(String query) async {
    if (query.isEmpty) {
      setState(() {
        list = [];
      });
      return;
    }

    List<SearchModel> results = [];

    // Fetch users
    QuerySnapshot userResults = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    print('User Results: ${userResults.docs.length}'); // Debug print

    for (var doc in userResults.docs) {
      var data = doc.data() as Map<String, dynamic>;
      results.add(SearchModel(
        id: doc.id,
        type: 'user',
        name: data['name'] ?? '',
        avatar: data['avatar'] ?? '',
        postImage: '', // Users don't have post images
        content: data['bio'] ?? '', // Users might have a bio
        isOfficial: data['role'] == 'official', // Assuming role field
      ));
    }

    // Fetch posts
    QuerySnapshot postResults = await FirebaseFirestore.instance
        .collection('posts')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    print('Post Results: ${postResults.docs.length}'); // Debug print

    for (var doc in postResults.docs) {
      var data = doc.data() as Map<String, dynamic>;
      results.add(SearchModel(
        id: doc.id,
        type: 'post',
        name: data['title'] ?? '',
        avatar: '', // Posts don't have profile images
        postImage: (data['images'] as List<dynamic>).isNotEmpty ? data['images'][0] : '',
        content: data['description'] ?? '',
        isOfficial: false, // Posts don't have official account status
      ));
    }

    setState(() {
      list = results;
    });

    print('Total Results: ${list.length}'); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        iconTheme: IconThemeData(color: context.iconColor),
        leadingWidth: 30,
        title: Container(
          decoration: BoxDecoration(color: context.cardColor, borderRadius: radius(8)),
          child: AppTextField(
            controller: searchController,
            textFieldType: TextFieldType.NAME,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Here',
              hintStyle: secondaryTextStyle(color: svGetBodyColor()),
              prefixIcon: Image.asset('images/tumy/icons/ic_Search.png',
                      height: 16, width: 16, fit: BoxFit.cover, color: svGetBodyColor())
                  .paddingAll(16),
            ),
            onChanged: (query) {
              search(query);
            },
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RESULTS', style: boldTextStyle()).paddingAll(16),
            ListView.separated(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SearchCardComponent(element: list[index]).onTap(() {
                  if (list[index].type == 'user') {
                    ProfileFragment().launch(context);
                  } else if (list[index].type == 'post') {
                    // Implement post details navigation here
                  }
                });
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 20);
              },
              itemCount: list.length,
            ),
          ],
        ),
      ),
    );
  }
}
