import 'package:flutter/material.dart';

import '../api/api.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List notiItems= [];
  bool isLoading = true;
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isLoading) {
      notiItems = await fetchData();
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  fetchData() async {
    List noti_items = [];
    noti_items = await APIService.getNoti();
    return noti_items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Notifications'),
      ),
      body:isLoading?Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: notiItems.length, // Replace with actual number of notifications
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 20.0,
              // Replace with actual profile picture
            ),
            title: Text(
              notiItems[index]['email'], // Replace with actual notification title
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Order received', // Replace with actual notification content
              style: TextStyle(fontSize: 14.0),
            ),
            onTap: ()async {
              List notis = await APIService.eachnotis(notiItems[index]['email']);
              // Show order details pop-up menu when tapping on notification
              showOrderDetailsPopupMenu(context, notiItems[index]['email'],notis);
            },
          );
        },
      ),
    );
  }

  void showOrderDetailsPopupMenu(
    BuildContext context,
    String customername,
    List notis
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details of $customername'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notis.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item Name : ${notis[index]['prod_name']}'),
                subtitle: Text('Count : ${notis[index]['count']}'),
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text('Confirm'),
              onPressed: () async {
                await APIService.confirmnoti(customername);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
