import 'package:easyconference/module/profile/edit.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileEdit(),
            )),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Avatar
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.17,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.height * 0.17,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:
                        AssetImage('assets/image/default-profile-picture.png'),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Username here",
                    decoration: const InputDecoration(labelText: 'Username'),
                    readOnly: true,
                  ),
                ),
                // Name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Name here",
                    decoration: const InputDecoration(labelText: 'Name'),
                    readOnly: true,
                  ),
                ),

                // Phone
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Phone here",
                    decoration: const InputDecoration(labelText: 'PhoneNumber'),
                    readOnly: true,
                  ),
                ),
                // Role
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Role here",
                    decoration: const InputDecoration(labelText: 'Role'),
                    readOnly: true,
                  ),
                ),
                // Expertise
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "RoExpertisele here",
                    decoration: const InputDecoration(labelText: 'Expertise'),
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
