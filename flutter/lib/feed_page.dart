import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 1.5,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Timestamp timestamp = data['timestamp'];
                Duration difference =
                    DateTime.now().difference(timestamp.toDate());
                String subtitleText;
                if (difference.inMinutes < 60) {
                  subtitleText = '${difference.inMinutes}m ago';
                } else {
                  DateTime recentHour =
                      DateTime.now().subtract(Duration(hours: 1));
                  if (timestamp.toDate().isAfter(recentHour)) {
                    subtitleText = '1h ago';
                  } else {
                    subtitleText = '${difference.inHours}h ago';
                  }
                }
                return
                  SizedBox(
                      height: 50,
                      child:
                  Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue[900]!, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data['post'],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '$subtitleText by ${data['name']} (${data['email']})',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
                  );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
