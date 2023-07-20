import 'package:curd_operations_app/models/contacts_models.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contacts = List.empty(growable: true);
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  int seleteIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text("No Contact yet....")
                : Expanded(
                    child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return getRow(index);
                        }),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBottomShet();
        },
        label: Text('Add Contact'),
      ),
    );
  }

  showBottomShet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: 450,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Contacts Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Contacts Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          var name = nameController.text.trim();
                          var contact = numberController.text.trim();
                          if (name.isNotEmpty && contact.isNotEmpty) {
                            setState(() {
                              nameController.text = "";
                              numberController.text = "";
                              contacts.add(
                                ContactModel(name: name, contact: contact),
                              );
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Add Contacts",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          var name = nameController.text.trim();
                          var contact = numberController.text.trim();
                          if (name.isNotEmpty && contact.isNotEmpty) {
                            setState(() {
                              nameController.text = "";
                              numberController.text = "";
                              contacts[seleteIndex].name = name;
                              contacts[seleteIndex].contact = contact;
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.deepPurple : Colors.green,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return editDelet(index);
                });
          },
          icon: Icon(Icons.more_vert),
        ),
      ),
    );
  }

  editDelet(int index) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              nameController.text = contacts[index].name;
              numberController.text = contacts[index].contact;
              setState(() {
                seleteIndex = index;
                Navigator.pop(context);
              });
              showBottomShet();
            },
            child: Text("Edit"),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              setState(() {
                contacts.removeAt(index);
                Navigator.pop(context);
              });
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
