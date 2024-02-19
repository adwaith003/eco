import 'package:app/pages/friends.dart';
import 'package:app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/pages/addfriend.dart';

class GroupCreate extends StatelessWidget {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Members'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Disable the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: groupTypeController,
              decoration: InputDecoration(
                labelText: 'Group Type',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String groupName = groupNameController.text;
                String groupType = groupTypeController.text;

                if (groupName.isNotEmpty && groupType.isNotEmpty) {
                  // Check if the group name already exists
                  bool groupExists = await _checkGroupExists(groupName);
                  if (groupExists) {
                    _showRenameDialog(context, groupName);
                  } else {
                    // Create a new document in the "groups" collection with the provided data
                    FirebaseFirestore.instance.collection('groups').add({
                      'groupName': groupName,
                      'groupType': groupType,
                    }).then((_) {
                      print('Group created successfully!');
                      // Optionally, navigate to a different page after creating the group
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFriendPage(),
                        ),
                      );
                    }).catchError((error) {
                      print('Error creating group: $error');
                    });
                  }
                } else {
                  _showAlertDialog(
                      context); // Show alert dialog if fields are empty
                }
              },
              child:
                  Text('Create Group', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkGroupExists(String groupName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupName', isEqualTo: groupName)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  void _showRenameDialog(BuildContext context, String groupName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Group Name Exists'),
          content: Text(
              'A group with the name "$groupName" already exists. Please enter a different name.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all required fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
